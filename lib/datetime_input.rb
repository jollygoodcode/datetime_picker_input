require "datetime_input/version"

module DatetimeInput
  class Engine < ::Rails::Engine
    require "bootstrap3-datetimepicker-rails"
    require "momentjs-rails"

    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.assets false
      g.helper false
    end
  end
end
