require "rails_helper"

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it "renders the :new template" do
      get :new, {}
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it "re-renders the new template" do
        post :create, params: { user: { username: "joep" } }
        expect(response).to render_template(:new)
      end
    end

    context "with valid params" do
      it "redirects to the root page" do
        post :create, params: { user: { username: "joep", password: "joespassword" } }
        expect(response).to redirect_to(:root)
      end
    end
  end
end
