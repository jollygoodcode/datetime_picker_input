require "feature_helper"

feature "datetime input", js: true do
  scenario "can create a new appointment with specific datetime" do
    visit root_path
    click_on "New Appointment"
    expect(page).to have_content "Scheduled at"
    page.execute_script("$('#appointment_scheduled_at').val('01/01/2046')")
    click_button "Create Appointment"
    expect(page).to have_content "2046-01-01 00:00:00 UTC"
  end
end
