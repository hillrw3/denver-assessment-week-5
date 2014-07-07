require 'spec_helper'

feature "Logged in" do

  scenario "Log out of site" do
  visit '/'
  click_on "Click here to logout"
  expect(page).to have_content("Contacts")
  end

end