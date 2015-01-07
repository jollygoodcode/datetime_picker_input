require 'rails'

module DatetimeInput
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      desc "This generator installs DatetimeInput #{DatetimeInput::VERSION}"
      source_root File.expand_path('../../templates', __FILE__)

      def install_datetime_picker_input
        say_status('Installing', "DatetimeInput (#{DatetimeInput::VERSION})", :green)
        template 'inputs/datetime_picker_input.rb', 'app/inputs/datetime_picker_input.rb' if !File.exist?('app/inputs/datetime_picker_input.rb')
      end
    end
  end
end
