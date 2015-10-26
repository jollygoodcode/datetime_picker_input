require "feature_helper"

feature "datetime input", js: true do

  [
    [
      "default",                   # context
      nil,                         # no server timezone
      { data: { date_format: "YYYY-MM-DD HH:mm:ss ZZ" } },
      "2015-10-25 00:00:00 +0800", # iso_format_string
      "2015-10-25 00:00:00 +0800", # date_format_output
    ],

    [
      "default with server tz",    # context
      'Central Time (US & Canada)',# server timezone does not matter
      { data: { date_format: "YYYY-MM-DD HH:mm:ss ZZ" } },
      "2015-10-25 00:00:00 +0800", # iso_format_string
      "2015-10-25 00:00:00 +0800", # date_format_output
    ],

    [
      "custom with tz",            # context
      nil,                         # no server timezone
      { data: { date_format: "DD.MM.YYYY hh:mm A ZZ" } },
      "2015-10-25 00:00:00 +0800", # iso_format_string
      "25.10.2015 12:00 AM +0800", # date_format_output
    ],

    [
      "custom with tz & server tz",# context
      'Central Time (US & Canada)',# server timezone does not matter
      { data: { date_format: "DD.MM.YYYY hh:mm A ZZ" } },
      "2015-10-25 00:00:00 +0800", # iso_format_string
      "25.10.2015 12:00 AM +0800", # date_format_output
    ],

    [
      "custom no timezone",        # context
      "Singapore",                 # server timezone required!
      { data: { date_format: "YYYY.MM.DD hh:mm A" } },
      "2015-10-25 00:00:00 +0800", # iso_format_string
      "2015.10.25 12:00 AM",       # date_format_output
    ],

  ].each do |context_name, server_timezone, input_html_options, iso_format_string, date_format_output|

    context context_name do
      before do
        Appointment.delete_all
        allow_any_instance_of(ApplicationHelper).to receive(:input_html_options).and_return(input_html_options)
        allow_any_instance_of(AppointmentsController).to receive(:current_timezone).and_return(server_timezone)
      end

      context 'create' do

        before do
          visit new_appointment_path
          page.execute_script("$('input.date_time_picker').val('#{date_format_output}')")
          page.find("body").click # blur
          expect(find_field('Scheduled at').value).to eq(date_format_output)
          # accepts keying in `iso_format_string` and will auto convert input[value] to `date_format_output` onblur
        end

        scenario 'accepted form post' do
          expect {
            click_button 'Create Appointment'
          }.to change {
            Appointment.last.try(:scheduled_at)
          }.to eq(Time.parse(iso_format_string))
          # value set in db must be correct
        end

        scenario 'rejected form post' do
          allow_any_instance_of(Appointment).to receive(:save).and_return(false)
          expect {
            click_button 'Create Appointment'
          }.not_to change {
            Appointment.count
          }
          expect(find_field('Scheduled at').value).to eq(date_format_output)
          # re-rendered input value should be identical to given value
        end
      end

      context 'edit' do
        let(:appointment) { Appointment.create(scheduled_at: iso_format_string) }

        scenario 'should convert raw_input_value to date_format_output' do
          visit edit_appointment_path(appointment)
          expect(find_field('Scheduled at')[:value]).to eq(Time.parse(iso_format_string).utc.strftime("%Y-%m-%d %H:%M:%S %z"))
          expect(find_field('Scheduled at').value).to eq(date_format_output)
        end
      end
    end

  end
end
