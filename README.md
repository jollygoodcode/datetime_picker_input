# DatetimePickerInput

[![Gem Version](https://badge.fury.io/rb/datetime_picker_input.svg)](https://badge.fury.io/rb/datetime_picker_input) [![Build Status](https://travis-ci.org/jollygoodcode/datetime_picker_input.svg?branch=feature%2Ftravis-ci)](https://travis-ci.org/jollygoodcode/datetime_picker_input)

DatetimePickerInput allows you to easily add a [JavaScript datetime picker](http://eonasdan.github.io/bootstrap-datetimepicker/) to your Ruby on Rails, Bootstrap-enabled Simple Form input.

## Prerequisites

Rails 3.1 and 4+ compatible, and your app should already have Bootstrap and Simple Form installed.

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

By default (without config), when you select a value from the DateTime picker, the format of the value
defaults to `YYYY-MM-DD HH:mm:ss Z`, i.e. `2015-10-25 14:33:02 +0800`.

This ensures that, out of the box, this value (with Time Zone) would be passed on to the Rails backend
and be saved as a DateTime value with the *correct Time Zone*.

Beneath the hood, Moment.js is used to parse and format value on the DateTime picker.
For other valid formats, please refer to [their Docs](http://momentjs.com/docs/#/displaying/).

#### Warning!

However, if you do change the format (like in the Customized Options example),
then you will need to implement your attribute setter and getter in Rails backend
to save and display the value correctly in your desired Time Zone.

One way to do this is to implement an `around_filter` on your controllers like so:

```ruby
class AppointmentsController < ApplicationController
  around_action :use_current_timezone

  # .. your controller code

  def use_current_timezone(&block)
    Time.use_zone(current_user.timezone, &block)
  end
end
```

This uses your `user`'s Time Zone, so that the DateTime gets stored and will be displayed as expected (from the user's perspective).

We are also assuming that, in this example, the `current_user` has set a custom Time Zone,
otherwise, you should just use the gem's default.

Times are hard..

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

[Bootstrap 3 Datepicker](https://github.com/Eonasdan/bootstrap-datetimepicker/blob/master/src/js/bootstrap-datetimepicker.js#L291) is able to initialize a datetime picker through the use of `data` attributes on the `input` field.

To do that, modify any of the options specified in [Bootstrap 3 Datepicker's Doc](http://eonasdan.github.io/bootstrap-datetimepicker/Options/) by adding a prefix of `date` and underscoring the resulting option name.

For example:

- `dayViewHeaderFormat` to `date_day_view_header_format`
- `minDate` to `date_min_date`

### Date Picker Only

```slim
= f.input :when, as: :date_time_picker, input_html: \
  { data: \
    { \
      date_format: "YYYY-MM-DD", \
    } \
  }
```

## Customization

To [customize the input field](https://github.com/plataformatec/simple_form/wiki/Adding-custom-input-components), you can copy `datetime_picker_input.rb` from the gem to your app by using the generator included in `datetime_picker_input`.

Simple do:

```bash
$ rails g datetime_picker_input:install
```

This will generate `datetime_picker_input.rb` under `app/inputs` directory which you can modify.

## Dependencies

This gem is heavily dependent on and only possible because of the great work done in these gems:

- https://github.com/TrevorS/bootstrap3-datetimepicker-rails
- https://github.com/derekprior/momentjs-rails

## Versioning

Since this gem is ultimately dependent on https://github.com/Eonasdan/bootstrap-datetimepicker, this gem shall have the same version as the JavaScript plugin - current release version is 4.0.0.

Any bug fix release of this gem will have a 4th decimal added, e.g. 4.0.0.1, 4.0.0.2.

## Contributing

Please see the [CONTRIBUTING.md](/CONTRIBUTING.md) file.

## Credits

A huge THANK YOU to all our [contributors](https://github.com/jollygoodcode/datetime_picker_input/graphs/contributors)! :heart:

## License

Please see the [LICENSE.md](/LICENSE.md) file.

## Maintained by Jolly Good Code

[![Jolly Good Code](https://cloud.githubusercontent.com/assets/1000669/9362336/72f9c406-46d2-11e5-94de-5060e83fcf83.jpg)](http://www.jollygoodcode.com)

We specialise in rapid development of high quality MVPs. [Hire us](http://www.jollygoodcode.com/#get-in-touch) to turn your product idea into reality.
