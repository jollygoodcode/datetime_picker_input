# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'datetime_input/version'

Gem::Specification.new do |spec|
  spec.name          = 'datetime_input'
  spec.version       = DatetimeInput::VERSION
  spec.authors       = %w(Juanito Fatas)
  spec.email         = %w(katehuang0320@gmail.com)
  spec.summary       = %(Datetime picker wrapper of https://github.com/TrevorS/bootstrap3-datetimepicker-rails, for use with simple_form on Rails 4+.)
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/jollygoodcode/datetime_input'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = %w(lib)

  spec.add_runtime_dependency 'bootstrap3-datetimepicker-rails'
  spec.add_runtime_dependency 'momentjs-rails'
end
