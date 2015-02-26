# DatetimePickerInput

[![Build Status](https://travis-ci.org/jollygoodcode/datetime_picker_input.svg?branch=feature%2Ftravis-ci)](https://travis-ci.org/jollygoodcode/datetime_picker_input)

Wrapper of https://github.com/TrevorS/bootstrap3-datetimepicker-rails, for use with Boostrap 3, simple_form 3.1 on Rails 4.1+.

## Installation

Add this line to your application's Gemfile then `bundle`:

```ruby
gem 'datetime_picker_input'
```

### Dependencies

- https://github.com/TrevorS/bootstrap3-datetimepicker-rails
- https://github.com/derekprior/momentjs-rails

In JavaScript Manifest file (`application.js`), add:

```js
//= require datetime_picker_input
```

In CSS Manifest file (`application.scss`), add:

```scss
@import 'datetime_picker_input';
```

or `application.css`:

```css
*= require datetime_picker_input
```

## Usage

In view (example in slim):

```slim
= f.input :starts_at, as: :date_time_picker, input_html:
  { data:
    { date_format: "YYYY-MM-DD hh:mm A",
      date_useminutes: false,
      date_sidebyside: false,
      date_mindate: Time.current.strftime('%Y-%m-%d')
    }
  }
```

## Customize datetime picker input

This gem includes [a custom simple_form input](https://github.com/plataformatec/simple_form/wiki/Adding-custom-input-components) by default, you can use generator to generate the underlying input then customize it.

First run the generator:

```bash
$ rails g datetime_picker_input:install
```

then edit the `date_time_picker_input.rb` under `app/inputs/` directory.

## Versioning

Same version as https://github.com/Eonasdan/bootstrap-datetimepicker since bootstrap3-datetimepicker-rails is based on https://github.com/Eonasdan/bootstrap-datetimepicker. Current release version is 4.0.0. Bugs of this gem will release a 4th version, e.g. 4.0.0.1, 4.0.0.2.

## Contributing

1. Fork it ( https://github.com/jollygoodcode/datetime_picker_input/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
