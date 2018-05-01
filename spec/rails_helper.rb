require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'capybara/rspec'
require "selenium/webdriver"
require 'support/controller_helpers'

# Add additional requires below this line. Rails is not loaded until this point!
# Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w(headless disable-gpu) }
  )

  Capybara::Selenium::Driver.new app, browser: :chrome, desired_capabilities: capabilities
end

Capybara.javascript_driver = :headless_chrome

ActiveRecord::Migration.maintain_test_schema!

OmniAuth.config.test_mode = true

OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
  provider: 'google_oauth2',
  uid: '123456789',
  info: {
    name: 'John Smith',
    email: 'john@example.com',
    first_name: 'John',
    last_name: 'Smith',
    image: 'https://lh4.googleusercontent.com/photo.jpg',
    urls: {
      google: 'https://plus.google.com/+JohnSmith'
    }
  },
  credentials: {
    token: "TOKEN",
    refresh_token: "REFRESH_TOKEN",
    expires_at: 1496120719,
    expires: true
  }
})

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.include Devise::TestHelpers, :type => :controller
  config.include ControllerHelpers, :type => :controller

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, type: :feature) do
    driver_shares_db_connection_with_specs = Capybara.current_driver == :selenium_chrome_headless

    unless driver_shares_db_connection_with_specs
      DatabaseCleaner.strategy = :truncation
    end
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.append_after(:each) do
    DatabaseCleaner.clean
  end
end
