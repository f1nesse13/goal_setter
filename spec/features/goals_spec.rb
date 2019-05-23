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

feature "ability to complete a goal" do
  scenario "has a edit goal page" do
    visit new_goal_url
    fill_in "Title", :with => "Generic Goal"
    fill_in "Description", :with => "Generic description"
    find("form input[type=submit]").click
    click_link("Complete")
    find_link("Have not completed").visible?
  end
end
