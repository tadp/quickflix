class ReviewsController < ApplicationController
  before_filter :require_user
  def create
    @video = Video.find(params[:video_id])

    # changed to "build" to create conditional
    # video.reviews.create(review_params.merge!(user: current_user))

    review = @video.reviews.build(review_params.merge!(user: current_user))
    if review.save
      redirect_to @video
    else
      #.reload discards the invalid reviews
      @reviews=@video.reviews.reload
      render "videos/show"
    end
    #Doesn't associate the reviews
    # Review.create(review_params)
  end

  private
  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
