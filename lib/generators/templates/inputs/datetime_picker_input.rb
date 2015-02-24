# Example
#
# = f.input :starts_at, as: :datetime_picker, input_html:
#   { data:
#     { date_format: "YYYY-MM-DD hh:mm A",
#       date_useminutes: false,
#       date_sidebyside: false,
#       date_mindate: Time.current.strftime('%Y-%m-%d')
#     }
#   }
#
# Refer to http://eonasdan.github.io/bootstrap-datetimepicker/#options
# for a full list of options

class DatetimePickerInput < SimpleForm::Inputs::StringInput
  def input(wrapper_options)
    input_html_options[:type] = "text"

    input_html_options[:data] ||= {}
    input_html_options[:data].reverse_merge!(
      date_format: picker_pattern,
      date_sidebyside: true
    )

    input_html_options[:value] ||= I18n.localize(attr_value, format: display_pattern) if attr_value.present?

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
      I18n.t("datepicker.dformat", default: "%d/%m/%Y") + " " + I18n.t("timepicker.dformat", default: "%R")
    end

    def picker_pattern
      I18n.t("datepicker.pformat", default: "DD/MM/YYYY") + " " + I18n.t("timepicker.pformat", default: "HH:mm")
    end

    def attr_value
      object.send(attribute_name) if object.respond_to? attribute_name
    end
end
