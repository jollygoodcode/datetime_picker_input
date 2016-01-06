require "feature_helper"

feature "datetime input", js: true do
  let(:datetime_value) { Time.parse("2015-10-25 00:00:00") }

  [
    [
      "default",                   # context
      nil,                         # no server timezone
      { data: { date_format: "YYYY-MM-DD HH:mm:ss ZZ" } },
      "%F %H:%M:%S %z",            # date_format
    ],

    [
      "default with server tz",    # context
      'Central Time (US & Canada)',# server timezone does not matter
      { data: { date_format: "YYYY-MM-DD HH:mm:ss ZZ" } },
      "%F %H:%M:%S %z",            # date_format
    ],

    [
      "custom with tz",            # context
      nil,                         # no server timezone
      { data: { date_format: "DD.MM.YYYY hh:mm A ZZ" } },
      "%d.%m.%Y %I:%M %p %z",      # date_format
    ],

    [
      "custom with tz & server tz",# context
      'Central Time (US & Canada)',# server timezone does not matter
      { data: { date_format: "DD.MM.YYYY hh:mm A ZZ" } },
      "%d.%m.%Y %I:%M %p %z",      # date_format
    ],

    [
      "custom no timezone",        # context
      TimeZone::Local.get().name,  # server timezone required!
      { data: { date_format: "YYYY.MM.DD hh:mm A" } },
      "%Y.%m.%d %I:%M %p",         # date_format
    ],

  ].each do |context_name, server_timezone, input_html_options, date_format|

    context context_name do
      let(:date_format_output) { datetime_value.strftime(date_format) }

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
        end

        scenario 'accepted form post' do
          expect {
            click_button 'Create Appointment'
          }.to change {
            Appointment.last.try(:scheduled_at)
          }.to eq(datetime_value)
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
        let(:appointment) { Appointment.create(scheduled_at: datetime_value) }

        scenario 'should convert raw_input_value to date_format_output' do
          visit edit_appointment_path(appointment)
          expect(find_field('Scheduled at').value).to eq(date_format_output)
        end
      end
    end

  end
end
