require "feature_helper"

feature "datetime input", js: true do

  [
    [
      "default",                   # context
      { data: { date_format: "YYYY-MM-DD HH:mm:ss ZZ" } },
      "2015-10-25 00:00:00 +0800", # iso_format_string
      "2015-10-25 00:00:00 +0800", # date_format_output
      "2015-10-24 16:00:00 +0000", # raw_input_value
    ],

    [
      "custom with timezone",      # context
      { data: { date_format: "DD.MM.YYYY hh:mm A ZZ" } },
      "2015-10-25 00:00:00 +0800", # iso_format_string
      "25.10.2015 12:00 AM +0800", # date_format_output
      "2015-10-24 16:00:00 +0000", # raw_input_value
    ],

    [
      "custom no timezone",        # context
      { data: { date_format: "YYYY.MM.DD hh:mm A" } },
      "2015-10-25 00:00:00 +0800", # iso_format_string
      "2015.10.25 12:00 AM",       # date_format_output
      "2015-10-24 16:00:00 +0000", # raw_input_value
    ],

  ].each do |context_name, input_html_options, iso_format_string, date_format_output, raw_input_value|

    context context_name do
      before do
        Appointment.delete_all
        allow_any_instance_of(ApplicationHelper).to receive(:input_html_options).and_return(input_html_options)
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
          }.to eq(DateTime.parse(date_format_output))
          # value set in db is `DateTime.parse(date_format_output)`
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
          expect(find_field('Scheduled at')[:value]).to eq(raw_input_value)
          expect(find_field('Scheduled at').value).to eq(date_format_output)
        end
      end
    end

  end

  scenario "can create a new appointment with specific datetime" do
    visit root_path
    click_on "New Appointment"
    expect(page).to have_content "Scheduled at"
    page.execute_script("$('input.date_time_picker').val('01/01/2046')")
    page.find("body").click # blur
    click_button "Create Appointment"
    expect(page).to have_content "2046-01-01 00:00:00 UTC"
  end
end
