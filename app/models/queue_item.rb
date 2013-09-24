
class QueueItem < ActiveRecord::Base
  belongs_to :video
  belongs_to :user

  validates_numericality_of :list_order, {only_integer: true} #mod5-1,half
  delegate :title, to: :video, prefix: :video

  # This is replaced with delegation
  # def video_title
  #   video.title
  # end

  def rating
    review = Review.where(user_id: user.id, video_id: video.id).first
    review.rating if review
  end

  def category_name
    video.categories.first.name
  end


end
