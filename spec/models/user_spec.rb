require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
  end

  subject { FactoryBot.build(:user) }

  it 'is valid with an email' do
    expect(subject.email).to eq "john@example.com"
  end

  it 'is valid with a name' do
    expect(subject.name).to eq "John Smith"
  end

  it 'is valid with an image' do
    expect(subject.image).to eq("https://lh4.googleusercontent.com/photo.jpg")
  end
end
