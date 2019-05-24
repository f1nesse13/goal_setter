require "spec_helper"
require "rails_helper"

feature "leaving comments" do
  scenario "on a user" do
    User.create(username: "joep", password: "joespassword")
    User.create(username: "layla", password: "laylaspassword")
    fill_in "Username", :with => "joep"
    fill_in "Password", :with => "joespassword"
    click_button "Login"
    visit user_url(2)
    fill_in "Comment", with: "new comment"
    click_button "Add Comment"
    expect(page).to have_text("Comment saved")
  end

  scenario "on a goal" do
    User.create(username: "joep", password: "joespassword")
    User.create(username: "layla", password: "laylaspassword")
    Goal.create(title: "Goal 1", details: "goal 1 details", user_id: 2)
    fill_in "Username", :with => "joep"
    fill_in "Password", :with => "joespassword"
    click_button "Login"
    visit goal_url(Goal.last.id)
    fill_in "Comment", with: "new comment"
    click_button "Add Comment"
    expect(page).to have_text("Comment saved")
  end
end

feature "viewing comments" do
  scenario "on a user" do
    User.create(username: "joep", password: "joespassword")
    User.create(username: "layla", password: "laylaspassword")
    fill_in "Username", :with => "joep"
    fill_in "Password", :with => "joespassword"
    click_button "Login"
    visit user_url(2)
    fill_in "Comment", with: "this is a new comment"
    click_button "Add Comment"
    visit user_url(2)
    expect(page).to have_text("this is a new comment")
  end

  scenario "on a goal" do
    User.create(username: "joep", password: "joespassword")
    User.create(username: "layla", password: "laylaspassword")
    Goal.create(title: "Goal 1", details: "goal 1 details", user_id: 2)
    fill_in "Username", :with => "joep"
    fill_in "Password", :with => "joespassword"
    click_button "Login"
    visit goal_url(1)
    fill_in "Comment", with: "this is a new comment"
    click_button "Add Comment"
    visit goal_url(1)
    expect(page).to have_text("this is a new comment")
  end
end
