require 'spec_helper'

feature "Root" do

  scenario "should say Contacts" do
    visit "/"
    expect(page).to have_content("Contacts")
  end

  scenario "should say login button" do
    visit "/"
    click_on "Login"
    expect(page).to have_content("Username:")
  end

end