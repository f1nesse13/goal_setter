require "rails_helper"

RSpec.describe User, type: :model do
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_length_of(:password).is_at_least(6) }

  describe "#is_password?" do
    it "should check if a users password is correct" do
      user = User.create(username: "joe@gmail.com", password: "joespassword")
      expect(user.is_password?("testpassword")).to be false
      expect(user.is_password?("joespassword")).to be true
    end
  end

  describe "::find_by_credentials" do
    it "should return the user if they exist and the password is correct" do
      User.create(username: "joe@gmail.com", password: "joespassword")
      expect(User.find_by_credentials("joe@gmail.com", "joespassword")).not_to be_nil
      expect(User.find_by_credentials("john@gmail.com", "joespassword")).to be_nil
      expect(User.find_by_credentials("joe@gmail.com", "johnspassword")).to be_nil
    end
  end

  describe "#reset_session_token!" do
    it "should reset a users current session token" do
      user = User.create!(username: "joe@gmail.com", password: "joespassword")
      current_session_token = user.session_token
      expect(current_session_token).not_to be_nil
      expect(user.reset_session_token!).not_to eq(current_session_token)
    end
  end
end
