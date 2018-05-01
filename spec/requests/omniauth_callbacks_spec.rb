require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :request do
  before do
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
  end

  describe "#google_oauth2" do
    it 'successfully create a user' do
      expect { post user_google_oauth2_omniauth_callback_url }.to change { User.count }.by(1)
    end

    it 'redirects the user to the root url' do
      post user_google_oauth2_omniauth_callback_url
      expect(response).to redirect_to root_url
    end

    # it 'redirects to the root url when user does not give consent' do
    #   OmniAuth.config.mock_auth[:google_oauth2] = nil
    #   post user_google_oauth2_omniauth_callback_url
    #   follow_redirect!
    #   expect(response.body).to include I18n.t('errors.access_not_granted')
    # end
  end
end
