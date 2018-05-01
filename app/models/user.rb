class User < ApplicationRecord
  devise :database_authenticatable, :omniauthable,
    omniauth_providers: [:google_oauth2]

  def self.from_omniauth(auth)
    User.find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.token = auth.credentials.token
      user.expires = auth.credentials.expires
      user.expires_at = auth.credentials.expires_at
      user.refresh_token = auth.credentials.refresh_token
      user.password = Devise.friendly_token[0,20]
    end
  end
end
