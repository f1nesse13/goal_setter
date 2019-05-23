require "spec_helper"
require "rails_helper"

feature "creating a goal" do
  scenario "has a new goal page" do
    visit new_goal_url
    expect(page).to have_content("New Goal")
  end

  scenario "redirects to goal after a goal is created" do
    visit new_goal_url
    fill_in "Title", :with => "Generic Goal"
    fill_in "Description", :with => "Generic description"
    find("form input[type=submit]").click
    expect(page).to have_text("Goal successfully created")
  end
end

feature "viewing created goals" do
  before(:each) do
    visit new_user_url
    fill_in "Username", :with => "joep"
    fill_in "Password", :with => "joespassword"
    click_on "Create Account"
  end
  scenario "view a public goal created by another user" do
    visit new_goal_url
    fill_in "Title", :with => "Generic Goal"
    fill_in "Description", :with => "Generic description"
    check("Public")
    find("form input[type=submit]").click
    click_on "Logout"
    visit new_user_url
    fill_in "Username", :with => "laylap"
    fill_in "Password", :with => "laylaspassword"
    click_on "Create Account"
    visit goal_url(Goal.last.id)
    expect(page).to have_text("Generic Goal")
  end

  scenario "unable to view a private goal created by another user" do
    visit new_goal_url
    fill_in "Title", :with => "Generic Goal"
    fill_in "Description", :with => "Generic description"
    uncheck("Public")
    find("form input[type=submit]").click
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
    visit new_goal_url
    fill_in "Title", :with => "Generic Goal"
    fill_in "Description", :with => "Generic description"
    find("form input[type=submit]").click
    click_link("Complete")
    find_link("Have not completed").visible?
  end

  feature "ability to delete a goal" do
    scenario "deleting a goal takes it off of users index page" do
      visit new_user_url
      fill_in "Username", :with => "joep"
      fill_in "Password", :with => "joespassword"
      click_on "Create Account"
      visit new_goal_url
      fill_in "Title", :with => "Generic Goal"
      fill_in "Description", :with => "Generic description"
      find("form input[type=submit]").click
      click_button("Delete this goal")
    end
  end
end
