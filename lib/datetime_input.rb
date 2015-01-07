require 'datetime_input/version'

module DatetimeInput
  class Engine < ::Rails::Engine
    require 'bootstrap3-datetimepicker-rails'
    require 'momentjs-rails'
  end
end
