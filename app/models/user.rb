class User < ApplicationRecord
  include Clearance::User
  has_many :authentications,
  dependent: :destroy

  def self.create_with_auth_and_hash(authentication, auth_hash)
  	user = User.create!(email: auth_hash[:extra][:raw_info][:email], first_name: auth_hash[:extra][:raw_info][:first_name], last_name: auth_hash[:extra][:raw_info][:last_name])
  	user.authentications << authentication
  	return user
  end

  def fb_token
  	x = self.authentications.where(provider: :facebook).first
  	return x.token unless x.nil?
  end

  private

  def password_optional?
    true
  end
end
