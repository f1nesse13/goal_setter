require "spec_helper"
require "rails_helper"

feature "creating a goal" do
  scenario "has a new goal page" do
    visit new_user_url
    fill_in "Username", :with => "laylap"
    fill_in "Password", :with => "laylaspassword"
    click_on "Create Account"
    visit new_goal_url
    expect(page).to have_text("Add a new goal")
  end
end

feature "view created goals" do
  scenario "public goal created by another user" do
    visit new_user_url
    fill_in "Username", with: "joep"
    fill_in "Password", with: "joespassword"
    click_on "Create Account"
    click_button "Create Goal"
    fill_in "Title", with: "Generic Goal"
    fill_in "Details", with: "Generic description"
    find("form .submit").click
    click_on "Logout"
    visit new_user_url
    fill_in "Username", with: "laylap"
    fill_in "Password", with: "laylaspassword"
    click_on "Create Account"
    visit goal_url(Goal.last.id)
    expect(page).to have_text("Generic Goal")
  end

  scenario "unable to view a private goal created by another user" do
    visit new_user_url
    fill_in "Username", :with => "joep"
    fill_in "Password", :with => "joespassword"
    click_on "Create Account"
    visit new_goal_url
    fill_in "Title", :with => "Generic Goal"
    fill_in "Details", :with => "Generic description"
    check("Private?")
    find("form .submit").click
    click_on "Logout"
    visit new_user_url
    fill_in "Username", :with => "laylap"
    fill_in "Password", :with => "laylaspassword"
    click_on "Create Account"
    visit goal_url(Goal.last.id)
    expect(page).to have_text("This goal is marked private")
  end
end

feature "ability to complete and delete a goal" do
  scenario "complete button edits completed status" do
    visit new_user_url
    fill_in "Username", :with => "laylap"
    fill_in "Password", :with => "laylaspassword"
    click_on "Create Account"
    visit new_goal_url
    fill_in "Title", :with => "Generic Goal"
    fill_in "Details", :with => "Generic description"
    find("form .submit").click
    click_on "Mark as complete"
    expect(page).to have_button("Mark as incomplete")
  end

  feature "ability to delete a goal" do
    scenario "deleting a goal takes it off of users index page" do
      visit new_user_url
      fill_in "Username", :with => "joep"
      fill_in "Password", :with => "joespassword"
      click_on "Create Account"
      visit new_goal_url
      fill_in "Title", :with => "Generic Goal"
      fill_in "Details", :with => "Generic description"
      find("form .submit").click
      click_button("Delete this goal")
      expect(page).not_to have_content("Generic Goal")
    end
  end
end
