# DatetimePickerInput

[![Build Status](https://travis-ci.org/jollygoodcode/datetime_picker_input.svg?branch=feature%2Ftravis-ci)](https://travis-ci.org/jollygoodcode/datetime_picker_input)

DatetimePickerInput allows you to easily add a JavaScript datetime picker to your Ruby on Rails, Bootstrap-enabled Simple Form input.

## Prerequisites

This gem is Rails 3.1 and 4+ compatible, and your app should already have Bootstrap and Simple Form installed.

Otherwise, set up [Bootstrap](https://github.com/twbs/bootstrap-sass) and [Simple Form](https://github.com/plataformatec/simple_form) now.

## Installation

Add this to your application's Gemfile then run `bundle install`:

```ruby
gem 'datetime_picker_input'
```

In the JavaScript manifest file `application.js`, add:

```js
//= require datetime_picker_input
```

In the CSS manifest file `application.scss`, add:

```scss
@import 'datetime_picker_input';
```

or `application.css`:

```css
*= require datetime_picker_input
```

## Usage

Demo app is available at [http://datetime-picker-input.herokuapp.com](http://datetime-picker-input.herokuapp.com).


### Simple Usage

```slim
= simple_form_for Event.new do |f|
  f.input :when, as: :date_time_picker
```

### Customized Options

```slim
= f.input :when, as: :date_time_picker, input_html:
  { data:
    {
      date_format: "YYYY-MM-DD hh:mm A",
      date_day_view_header_format: 'MMM YYYY',
      date_side_by_side: true,
      date_min_date: Time.current.strftime('%Y-%m-%d')
    }
  }
```

[Bootstrap 3 Datepicker](https://github.com/Eonasdan/bootstrap-datetimepicker/blob/master/src/js/bootstrap-datetimepicker.js#L291) provides the option to initialize a datetime picker through the use of `data` attributes on the `input` field.

To do that, modify any of the options specified in [Bootstrap 3 Datepicker's Doc](http://eonasdan.github.io/bootstrap-datetimepicker/Options/) by adding a prefix of `date` and underscoring the resulting option.

For example:

- `dayViewHeaderFormat` to `date_day_view_header_format`
- `minDate` to `date_min_date`

## Customization

To [customize the input field](https://github.com/plataformatec/simple_form/wiki/Adding-custom-input-components), you can copy `datetime_picker_input.rb` from the gem to your app by using the generator included in `datetime_picker_input`.

Simple do:

```bash
$ rails g datetime_picker_input:install
```

This will generate `datetime_picker_input.rb` under `app/inputs` directory. Then you can start customizing it.

## Dependencies

This gem is heavily dependent on and only possible because of the great work done in these other gems:

- https://github.com/TrevorS/bootstrap3-datetimepicker-rails
- https://github.com/derekprior/momentjs-rails

## Versioning

Since this gem is ultimately reliant on https://github.com/Eonasdan/bootstrap-datetimepicker, it shall have the same version as the JavaScript plugin.

Current release version is 4.0.0. Any bug fix release of this gem will have a 4th decimal added, e.g. 4.0.0.1, 4.0.0.2.

## Contributing

1. Fork it ( https://github.com/jollygoodcode/datetime_picker_input/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Credits

A huge THANK YOU to all our [contributors] (https://github.com/jollygoodcode/datetime_picker_input/graphs/contributors)! :heart:

This project is maintained by [Jolly Good Code](http://www.jollygoodcode.com).

## License

MIT License. See [LICENSE](LICENSE) for details.
