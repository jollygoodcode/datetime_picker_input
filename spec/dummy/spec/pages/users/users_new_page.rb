require_relative '../page_object/base'

class UsersNewPage
  include PageObject::Base

  has_url '/users/new'
  matches /\/users\/new/
  element :datepicker

  def click_datepicker_field
    datepicker.click
  end
end
