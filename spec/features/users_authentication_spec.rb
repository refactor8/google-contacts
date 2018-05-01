require 'rails_helper'

RSpec.feature 'Signing in', type: :feature do  
  scenario 'Signing in with Google' do
    visit root_path
    click_link 'Sign in with Google'
    expect(page).to have_content 'Successfully authenticated from Google account.'
  end

  scenario 'Signing out' do
    visit root_path
    click_link 'Sign in with Google'
    click_link 'Log out'
    expect(page).to have_content 'Signed out successfully.'
  end
end
