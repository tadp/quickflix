require 'spec_helper'

describe QueueItemsController do

  describe "GET index" do
    it "sets @queue_items to the queue items of the logged in user" do
      alice = Fabricate(:user)
      set_current_user(alice)
      queue_item1 = Fabricate(:queue_item, user: alice)
      queue_item2 = Fabricate(:queue_item, user: alice)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end

    it_behaves_like "requires sign in" do
      let(:action) { get :index }
    end

    # mod 6.1 Sending
    # it "redirects to the sign in page for unauthenticated users" do
    #   get :index
    #   expect(response).to redirect_to login_path
    # end

  end

  describe "POST create" do

    before { set_current_user }

    it "redirects to the my queue page" do
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(response).to redirect_to my_queue_path
    end

    it "creates a queue item" do
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.count).to eq(1)
    end

    it "creates the queue item that is associated with the video" do
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.video).to eq(video)
    end

    it "creates the queue item that is associated with the signed in user" do
      alice = Fabricate(:user)
      set_current_user(alice)
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.user).to eq(alice)
    end


    it "puts the video as the last one in the queue" do
      alice = Fabricate(:user)
      set_current_user(alice)
      monk = Fabricate(:video)
      Fabricate(:queue_item, video: monk, user: alice)
      south_park = Fabricate(:video)
      post :create, video_id: south_park.id
      south_park_queue_item = QueueItem.where(video_id: south_park.id, user_id: alice.id).first
      expect(south_park_queue_item.list_order).to eq(2)
    end
    it "does not add the video into the queue if the video is already in the queue" do
      alice = Fabricate(:user)
      set_current_user(alice)
      monk = Fabricate(:video)
      Fabricate(:queue_item, video: monk, user: alice)
      post :create, video_id: monk.id
      expect(alice.queue_items.count).to eq(1)
    end

    it_behaves_like "requires sign in" do
      let(:action) { post :create, video_id: 3}
    end

  end

  describe "DELETE destroy" do
    it "redirects to the my queue page" do
      alice = Fabricate(:user)
      set_current_user(alice)
      queue_item = Fabricate(:queue_item, user_id: alice.id)
      delete :destroy, id: queue_item.id
      expect(response).to redirect_to my_queue_path
    end
    it "deletes the queue item" do
      alice = Fabricate(:user)
      set_current_user(alice)
      queue_item = Fabricate(:queue_item, user: alice)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(0)
    end

    it "does not delete the queue item if the queue item is not in the current user's queue" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      set_current_user(alice)
      queue_item = Fabricate(:queue_item, user: bob)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(1)
    end

     it "should re-number remaining records with correct positions" do
        alice = Fabricate(:user)
        set_current_user(alice)
        queue_item1 = Fabricate(:queue_item, user: alice, list_order: 1)
        queue_item2 = Fabricate(:queue_item, user: alice, list_order: 2)
        get :destroy, id: queue_item1.id
        expect(alice.queue_items.first.list_order).to eq(1)
     end

      it_behaves_like "requires sign in" do
        let(:action) { delete :destroy, id: 3 }
      end
  end

  describe "POST update_queue" do

    it_behaves_like "requires sign in" do
      let(:action) do
        post :update_queue, queue_items: [{id:2, list_order: 3}, {id: 4, list_order: 2}]
      end
    end
    
    context "with valid inputs" do
      let(:alice) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      let(:queue_item1) { Fabricate(:queue_item, user: alice, video: video, list_order: 1) }
      let(:queue_item2) { Fabricate(:queue_item, user: alice, video: video, list_order: 2) }

      before do
        set_current_user(alice)
      end

      it "redirects_to my_queue page" do
        post :update_queue, queue_items: [{id: queue_item1, list_order: 2}, {id: queue_item2.id, list_order: 1}]
        expect(response).to redirect_to my_queue_path
      end

      it "reorders the queue items" do
        post :update_queue, queue_items: [{id: queue_item1.id, list_order: 2}, {id: queue_item2.id, list_order: 1}]
        expect(alice.queue_items).to eq([queue_item2, queue_item1])
      end

      it "normalizes the position numbers" do
        post :update_queue, queue_items: [{id: queue_item1.id, list_order: 3}, {id: queue_item2.id, list_order: 2}]
        # In the next two lines, we need to reload because the variables set before do not know that the underlying data has changed.
        # expect(queue_item1.reload.list_order).to eq(2)
        # expect(queue_item2.reload.list_order).to eq(1)
        expect(alice.queue_items.map(&:list_order)).to eq([1,2])
      end
    end

    context "with invalid inputs" do 
      let(:alice) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      let(:queue_item1) { Fabricate(:queue_item, user: alice, video: video, list_order: 1) }
      let(:queue_item2) { Fabricate(:queue_item, user: alice, video: video, list_order: 2) }

      before do
        set_current_user(alice)
      end

      it "redirects to the my queue page" do
        post :update_queue, queue_items: [{id: queue_item1.id, video: video, list_order: 3.5}, {id: queue_item2.id, list_order: 1}]
        expect(response).to redirect_to my_queue_path
      end
      it "sets the flash message" do
        post :update_queue, queue_items: [{id: queue_item1.id, list_order: 3.5}, {id: queue_item2.id, list_order: 1}]
        expect(flash[:error]).to be_present
      end

      it "does not change the queue items" do
        post :update_queue, queue_items: [{id: queue_item1.id, list_order: 3}, {id: queue_item2.id, list_order: 2.1}]
        expect(alice.queue_items).to eq([queue_item1, queue_item2])
      end

    end



    context "with queue items that do not belong to the current user" do
      it "does not change the queue items" do
        alice = Fabricate(:user)
        set_current_user(alice)
        video = Fabricate(:video)
        bob = Fabricate(:user)
        queue_item1 = Fabricate(:queue_item, user: bob, video: video, list_order: 1)
        queue_item2 = Fabricate(:queue_item, user: alice, video: video, list_order: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, list_order: 3}, {id: queue_item2.id, list_order: 2}]
        expect(queue_item1.reload.list_order).to eq(1)
       end
    end
    
  end

end
