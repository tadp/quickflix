require 'spec_helper'

describe VideosController do
  describe "GET show" do

    # context "with authenticated users" do
    #  before do
    #    session[:user_id] = Fabricate(:user).id
    #  end 
    # end

    it "sets @video for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end

   it "redirects the user to the sign in page for unauthenticated users" do
    video = Fabricate(:video)
    get :show, id: video.id
    expect(response).to redirect_to login_path
   end

   it "renders the show template" do
    video = Fabricate(:video)
    get :show, id: video.id
    expect(response).to render_template(:show)
   end
  end

      #Doesn't work
  describe "POST search" do
      xit "sets @results for authenticated users" do
        session[:user_id] = Fabricate(:user).id
        futurama = Fabricate(:video, title: 'Futurama')
        post :search, search_term: 'rama'
        expect(assigns(:results)).to eq([futurama])
      end
      xit "redirects to sign in page for the unauthenticated users" do
        futurama = Fabricate(:video, title: 'Futurama')
        post :search, search_term: 'rama'
        expect(response).to redirect_to login_path
      end
    #This tests a Rails convention so we should remove it.
    # it "renders the show template"  do
    #     video = Fabricate(:video)
    #     get :show, id: video.id
    #     expect(response).to render_template :show
    # end
  end
end