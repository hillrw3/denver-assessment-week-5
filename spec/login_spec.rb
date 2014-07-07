require 'spec_helper'

feature "Login" do

  scenario "login to the website" do
    visit "/login"
    fill_in 'Username:', with: "Jeff"
    fill_in 'Password:', with: "jeff123"
    click_on "login"
    expect(page).to have_content("Welcome, Jeff")
    expect(page).to have_content("Spencer")
    expect(page).to have_content("spen@example.com")
  end

end