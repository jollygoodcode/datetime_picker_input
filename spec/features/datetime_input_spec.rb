require "feature_helper"

feature "datetime input", js: true do
  scenario "Make sure dummy app is up and runnning" do
    visit appointments_path
    expect(page).to have_content "Appointments"
  end
end
