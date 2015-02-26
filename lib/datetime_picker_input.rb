require "datetime_picker_input/version"

module DatetimePickerInput
  class Engine < ::Rails::Engine
    require "bootstrap3-datetimepicker-rails"
    require "momentjs-rails"
  end
end
