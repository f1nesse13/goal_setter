require "spec_helper"
require "rails_helper"

feature "the signup process" do
  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content("Sign Up")
  end

  feature "signing up a user" do
    scenario "shows username on the homepage after signup" do
      visit new_user_url
      fill_in "Username", :with => "joep"
      fill_in "Password", :with => "joespassword"
      click_on "Create Account"
      expect(page).to have_content("joep")
    end
  end
end

feature "logging in" do
  scenario "shows username on the homepage after login" do
    User.create(username: "joep", password: "joespassword")
    visit new_session_url
    fill_in "Username", :with => "joep"
    fill_in "Password", :with => "joespassword"
    find("form input[type=submit]").click
    expect(page).to have_content("joep's Profile")
  end
end

feature "logging out" do
  scenario "begins with a logged out state" do
    visit users_url
    expect(page).not_to have_content("Logout")
  end

  scenario 'doesn\'t show logout button on the users page after logout' do
    User.create(username: "joep", password: "joespassword")
    visit new_session_url
    fill_in "Username", :with => "joep"
    fill_in "Password", :with => "joespassword"
    find("form input[type=submit]").click
    click_link("Logout")
    expect(page).not_to have_content("Logout")
  end
end
