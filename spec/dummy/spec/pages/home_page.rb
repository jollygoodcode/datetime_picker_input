require_relative 'page_object/base'

class HomePage
  include PageObject::Base

  has_url '/'
  matches /\//
end
