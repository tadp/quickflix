
class QueueItem < ActiveRecord::Base
  belongs_to :video
  belongs_to :user

  validates_numericality_of :list_order, {only_integer: true} #mod5-1,half
  delegate :category, to: :video
  delegate :title, to: :video, prefix: :video

  # This is replaced with delegation
  # def video_title
  #   video.title
  # end

  def rating
    review.rating if review
    # video.reviews.first.try(:rating)
  end

  # Virtual attribute for ActiveRecord model. mod 5.3
  def rating=(new_rating)
    if review
      review.update_column(:rating, new_rating)
    else
      review = Review.new(user_id: user.id, video_id: video.id, rating: new_rating)
      review.save(validate: false)
    end
  end

  def category_name
    video.categories.first.name
  end

  private

  def review
    @review ||= Review.where(user_id: user.id, video_id: video.id).first
  end


end
