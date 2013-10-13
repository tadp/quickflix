require 'spec_helper'

describe InvitationsController do

  describe "GET new" do
    it "sets @invitation to a new invitation" do
      set_current_user
      get :new
      expect(assigns(:invitation)).to be_new_record
      expect(assigns(:invitation)).to be_instance_of Invitation
    end

    it_behaves_like "requires sign in" do
      let(:action) { get :new }
    end

  end

  describe "POST create" do

    it_behaves_like "requires sign in" do
      let(:action) { post :create }
    end

    context "with valid inputs" do

      after { ActionMailer::Base.deliveries.clear }

      it "redirects to the invitation new page" do
        set_current_user
        post :create, invitation: { recipient_name: "Joe Smith", recipient_email: "joe@example.com", message: "Hey, check out this cool app!"}
        expect(response).to redirect_to new_invitation_path
      end

      it "creates an invitation" do
        set_current_user
        post :create, invitation: { recipient_name: "Joe Smith", recipient_email: "joe@example.com", message: "Hey, check out this cool app!"}
        expect(Invitation.count).to eq(1)
      end
      it "sends an email to the recipient" do
        set_current_user
        post :create, invitation: { recipient_name: "Joe Smith", recipient_email: "joe@example.com", message: "Hey, check out this cool app!"}
        expect(ActionMailer::Base.deliveries.last.to).to eq(['joe@example.com'])
      end

      it "sets the flash success message" do
        set_current_user
        post :create, invitation: { recipient_name: "Joe Smith", recipient_email: "joe@example.com", message: "Hey, check out this cool app!"}
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid input" do

      after { ActionMailer::Base.deliveries.clear }
      
      it "renders the :new template" do
        set_current_user
        post :create, invitation: {recipient_email: "joe@example.com", message: "Hey join Myflix!"}
        expect(response).to render_template :new
      end
      it "does not create an invitation" do
        set_current_user
        post :create, invitation: {recipient_email: "joe@example.com", message: "Hey join Myflix!"}
        expect(Invitation.count).to eq(0)
      end
      it "does not send out an email" do

        set_current_user
        post :create, invitation: {recipient_email: "joe@example.com", message: "Hey join Myflix!"}
        expect(ActionMailer::Base.deliveries).to be_empty
      end
      it "sets the flash error message" do
        set_current_user
        post :create, invitation: {recipient_email: "joe@example.com", message: "Hey join Myflix!"}
        expect(flash[:error]).to be_present
      end
      it "sets @invitation" do
        set_current_user
        post :create, invitation: {recipient_email: "joe@example.com", message: "Hey join Myflix!"}
        expect(assigns(:invitation)).to be_present
      end
    end


    # context "with valid inputs" do
    #   xit "redirects to My Queue after submit" do
    #     alice = Fabricate(:user)
    #     sign_in(alice)
    #     visit invitation_path
    #     post :create, name: "Bobby Jones", email: "bobby@example.com", message: "Come join us!"
    #     expect(response).to redirect_to my_queue_path
    #   end

    #   it "allows the user to register" do
    #   end
    # end

    # context "sending emails" do
    #   after { ActionMailer::Base.deliveries.clear }

    #   xit "contains the user's name with valid inputs" do
    #     alice = Fabricate(:user)
    #     sign_in(alice)
    #     visit invitation_path
    #     post :create, { name: "Joe Smith", email: alice.email, message: "Come join us!"}
    #     expect(ActionMailer::Base.deliveries.last.body).to include('Come join us!') 
    #   end

    #   xit "does not send out email (with invalid inputs)" do
    #     alice = Fabricate(:user)
    #     post :create,{ email: "joe_not_send@example.com" }
    #     expect(ActionMailer::Base.deliveries).to be_empty
    #   end
    # end

  end
end