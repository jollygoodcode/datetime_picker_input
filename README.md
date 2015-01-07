# DatetimeInput

Wrapper of https://github.com/TrevorS/bootstrap3-datetimepicker-rails, for use with simple_form on Rails 4+.

## Installation

Add this line to your application's Gemfile then `bundle`:

```ruby
gem 'datetime_input'
```

### Dependencies

- https://github.com/TrevorS/bootstrap3-datetimepicker-rails
- https://github.com/derekprior/momentjs-rails

```
$ rails g datetime_input:install
```

This will generates a `datetime_picker_input.rb` under `app/inputs`.

In JavaScript Manifest file (`application.js`), add:

```
//= require datetime_input
```

In CSS Manifest file (`application.scss`), add:

```
@import 'datetime_input';
```

or `application.css`:

```
*= require datetime_input
```

## Versioning

Same version as https://github.com/Eonasdan/bootstrap-datetimepicker since bootstrap3-datetimepicker-rails is based on https://github.com/Eonasdan/bootstrap-datetimepicker. Current release version is 3.1.3. Bugs of this gem will release a 4th version, e.g. 3.1.3.1, 3.1.3.2.

## Usage

In view (example in slim):

```
= f.input :starts_at, as: :datetime_picker, input_html:
  { data:
    { date_format: "YYYY-MM-DD hh:mm A",
      date_useminutes: false,
      date_sidebyside: false,
      date_mindate: Time.current.strftime('%Y-%m-%d')
    }
  }
```

## Contributing

1. Fork it ( https://github.com/jollygoodcode/datetime_input/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
