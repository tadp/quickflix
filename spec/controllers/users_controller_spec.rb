require 'spec_helper'
require 'pry'

describe UsersController do
  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end 
  
  describe "POST create" do
    context "with valid input" do
      it "creates the user" do
        post :create, user: Fabricate.attributes_for(:user)
        expect(User.count).to eq(1)
      end

      it "redirects to login path" do
        post :create, user: { email: "test@example.com", password: "password", full_name: "Bob Jones" }
        expect(response).to redirect_to login_path
      end
    end

    context "with invalid input" do
      it "does not create the user" do
        post :create, user: { email: "test@example.com", full_name: "Bob Jones" }
        expect(User.count).to eq(0)
      end

      it "render the :new template" do
        post :create, user: { email: "test@example.com", full_name: "Bob Jones" }
        expect(response).to render_template :new
      end

      it "sets @user" do
        post :create, user: { email: "test@example.com", full_name: "Bob Jones" }
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end
end