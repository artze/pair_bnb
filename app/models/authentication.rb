class Authentication < ApplicationRecord
  belongs_to :user

  def self.create_with_omniauth(auth_hash)
  	auth = Authentication.new(uid: auth_hash[:uid], token: auth_hash[:credentials][:token], provider: auth_hash[:provider])
  end

  def update_token(auth_hash)
  	self.token = auth_hash[:credentials][:token]
  	self.save
  end
end