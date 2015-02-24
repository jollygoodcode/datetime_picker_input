require 'feature_helper'

feature 'Datetime picker', :js do
  scenario 'Click datetimepicker field and a date will be selected' do
    # app.users_new_page.visit_url

    # expect(app.users_new_page).to be_current

    # app.reviews_new_page.click_datepicker_field

    visit '/users/new'
    year = Time.current.year
    click_on '#user_created_at'
    expect(page).to have_content year
  end
end
