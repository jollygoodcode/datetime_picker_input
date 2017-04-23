require "rails_helper"

require "capybara/rails"
require "capybara/rspec"
require "capybara/poltergeist"
require "database_cleaner"
require "timezone_local"

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(
    app,
    window_size: [1280, 1024],
    js_errors: false, debug: false
  )
end

Capybara.configure do |config|
  config.javascript_driver = :poltergeist
end

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
    require "fileutils"
    FileUtils.rm_rf "#{Rails.root}/tmp/"
  end
end
