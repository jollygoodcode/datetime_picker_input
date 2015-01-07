require 'rails_helper'

Dir[Rails.root.join("spec/pages/**/*.rb")].each { |f| require f }

require 'capybara/poltergeist'

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
