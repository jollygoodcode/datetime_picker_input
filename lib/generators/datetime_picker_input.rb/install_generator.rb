require "rails"

module DatetimePickerInput
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      desc "This generator installs DatetimePickerInput #{DatetimePickerInput::VERSION}"
      source_root File.expand_path("../../templates", __FILE__)

      def install_datetime_picker_input
        say_status("Installing", "DatetimePickerInput (#{DatetimePickerInput::VERSION})", :green)
        template "inputs/datetime_picker_input.rb", "app/inputs/datetime_picker_input.rb" if !File.exist?("app/inputs/datetime_picker_input.rb")
      end
    end
  end
end
