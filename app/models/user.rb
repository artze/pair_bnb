class User < ApplicationRecord
  include Clearance::User
  has_many :authentications, dependent: :destroy
  has_many :listings, dependent: :destroy
  has_many :reservations, dependent: :destroy
  validates :first_name, :last_name, presence: true

  @@facebook = false

  def self.create_with_auth_and_hash(authentication, auth_hash)
  	user = User.create!(email: auth_hash[:extra][:raw_info][:email], first_name: auth_hash[:extra][:raw_info][:first_name], last_name: auth_hash[:extra][:raw_info][:last_name])
  	user.authentications << authentication
  	return user
  end

  def fb_token
  	x = self.authentications.where(provider: :facebook).first
  	return x.token unless x.nil?
  end

  def self.non_facebook_signup
    @@facebook = false
  end

  def self.facebook_signup
    @@facebook = true
  end

  private

  def password_optional?
    true if @@facebook == true
  end
end