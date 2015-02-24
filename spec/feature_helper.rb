require "rails_helper"

require "capybara/rails"
require "capybara/rspec"
require "capybara/poltergeist"
require "database_cleaner"

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
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

