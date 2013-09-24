class QueueItemsController < ApplicationController
  before_filter :require_user

  def index
    @queue_items= current_user.queue_items
  end

  def create
    video = Video.find(params[:video_id])
    # Two most common refactoring techniques is to extract the method or extract class. Mod4.2 17:29
    # QueueItem.create(video: video, user: current_user, list_order: current_user.queue_items.count + 1) unless current_user.queue_items.map(&:video).include?(video)
    queue_video(video)
    redirect_to my_queue_path
  end

  def destroy
    queue_item = QueueItem.find(params[:id])
    queue_item.destroy if current_user.queue_items.include?(queue_item)
    queue_item.user.reorder_queue_items
    redirect_to my_queue_path
  end

  def update_queue
    begin
     update_queue_items
     current_user.reorder_queue_items
      rescue ActiveRecord::RecordInvalid  #5.1:32:06
        flash[:error] = "Invalid position numbers."
      end
      redirect_to my_queue_path
  end

  private

  def queue_video(video)
    QueueItem.create(video: video, user: current_user, list_order: new_queue_item_position) unless current_user_queued_video?(video)
  end

  def new_queue_item_position
   current_user.queue_items.count + 1
  end

  def current_user_queued_video?(video)
    current_user.queue_items.map(&:video).include?(video)
  end

  def update_queue_items
    ActiveRecord::Base.transaction do
      params[:queue_items].each do |queue_item_data|
        queue_item = QueueItem.find(queue_item_data[:id])
        queue_item.update_attributes!(list_order: queue_item_data[:list_order], rating: queue_item_data["rating"]) if queue_item.user == current_user #mod 5.1 "!" raise exception for transaction
      end
    end
  end

end
