# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'factory_bot_rails'
require 'shoulda/matchers'
require 'spec_helper'
require 'pundit/rspec'
require 'webdrivers'

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end
RSpec.configure do |config|
  config.mock_with :rspec
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::IntegrationHelpers, type: :feature

  Webdrivers::Geckodriver.required_version = Webdrivers::Geckodriver.latest_version

  Capybara.app = Rails.application

  config.before(:each, type: :feature, js: true) do
    Capybara.register_driver :selenium_firefox do |app|
      Capybara::Selenium::Driver.new(app, browser: :firefox)
    end

    Capybara.current_driver = :selenium_firefox
    Capybara.javascript_driver = :selenium_firefox
  end
end
