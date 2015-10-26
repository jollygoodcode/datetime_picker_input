# Example:
#
# = simple_form_for Event.new do |f|
#   = f.input :when, as: :date_time_picker, input_html: \
#     { data: \
#       { \
#         date_format: "YYYY-MM-DD hh:mm A Z", \
#         date_day_view_header_format: 'MMM YYYY', \
#         date_side_by_side: true, \
#         date_min_date: Time.current.strftime('%Y-%m-%d') \
#       } \
#     }
#
# Refer to http://eonasdan.github.io/bootstrap-datetimepicker/#options for a full list of options.
#
class DateTimePickerInput < SimpleForm::Inputs::StringInput
  def input(wrapper_options)
    input_html_options[:type] = "text"

    input_html_options[:data] ||= {}
    input_html_options[:data].reverse_merge!(date_format: picker_pattern)

    input_html_options[:value] ||= I18n.localize(attr_value.utc, format: display_pattern) if attr_value.present?

    template.content_tag :div, class: "input-group date datetime_picker" do
      input = super(wrapper_options)
      input += template.content_tag :span, class: "input-group-btn" do
        template.content_tag :button, class: "btn btn-default", type: "button" do
          template.content_tag :i, "", class: "glyphicon glyphicon-calendar"
        end
      end
      input
    end
  end

  def input_html_classes
    super.push "" # 'form-control'
  end

  private

    def display_pattern
      "%Y-%m-%d %H:%M:%S %z"
    end

    def picker_pattern
      "YYYY-MM-DD HH:mm:ss ZZ"
    end

    def attr_value
      object.send(attribute_name) if object.respond_to? attribute_name
    end
end
