require 'spec_helper'

describe Admin::CategoriesController do
  describe "GET new" do
    it_behaves_like "requires sign in" do
      let(:action) { get :new }
    end

    it "sets the @video to a new video" do
      set_current_admin
      get :new
      expect(assigns(:category)).to be_instance_of Category
      expect(assigns(:category)).to be_new_record
    end

    it_behaves_like "requires admin" do
      let(:action) { post :create }
    end

    it "sets the flash error message for the regular user" do
      set_current_user
      get :new
      expect(flash[:error]).to be_present
    end

    it "does not set the flash error message for the admin" do
      set_current_admin
      get :new
      expect(flash[:error]).to_not be_present
    end
  end


  describe "POST create" do
    it_behaves_like "requires sign in" do
      let(:action) { post :create, category: { name: "Comedy" } }
    end

    it_behaves_like "requires admin" do
      let(:action) { post :create, category: { name: "Comedy" } }
    end

    context "with valid inputs" do
      it "redirects to the add new category page" do
        set_current_admin
        post :create, category: { name: "Comedy" }
        expect(response).to redirect_to new_admin_category_path
      end

      it "creates a category" do
        set_current_admin
        post :create, category: { name: "Comedy" }
        expect(Category.all.count).to eq(1)
      end

      it "sets the flash success message" do
        set_current_admin
        post :create, category: { name: "Comedy" }
        expect(flash[:success]).to be_present
      end
    end
    context "with invalid inputs" do
      it "does not create a category" do
        set_current_admin
        post :create, category: { description: "good show!" }
        expect(Category.all.count).to eq(0)
      end
      it "renders the :new template" do
        set_current_admin
        post :create, category: { description: "good show!" }
        expect(response).to render_template :new
      end
      it "sets the @category variable" do
        set_current_admin
        post :create, category: { description: "good show!" }
        expect(assigns(:category)).to be_present
      end

      it "sets the flash error message" do
        set_current_admin
        post :create, category: { description: "good show!" }
        expect(flash[:error]).to be_present
      end
    end

  end
end
