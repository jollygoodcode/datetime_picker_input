require "rails_helper"

class Event
  include ActiveModel::Model

  attr_accessor :when
end

describe "DateTimePickerInput", type: :helper do
  describe "#input" do
    def input_for(object, attr_name, options={})
      helper.simple_form_for object, url: '' do |f|
        f.input attr_name, options
      end
    end

    context "field without value" do
      let(:obj)  { Event.new }

      it "includes default `date_extra_formats" do
        output = input_for(obj, :when, as: :date_time_picker)
        expect(output).to match /data-date-format=.*YYYY-MM-DD HH:mm:ss ZZ.*"/
      end
    end

    context "field with value" do
      let(:obj)  { Event.new(when: time) }
      let(:time) { Time.current }

      it "includes formatted value" do
        output = input_for(obj, :when, as: :date_time_picker)
        expect(output).to match /value="#{Regexp.quote(time.strftime("%Y-%m-%d %H:%M:%S %z"))}"/
      end
    end
  end
end
