class Admin::VideosController < ApplicationController
  before_filter :require_user
  before_filter :require_admin

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      flash[:success] = "You successfully added the video '#{@video.title}."
      redirect_to new_admin_video_path
    else
      flash[:error] = "You cannot add this video. Please check the errors"
      render :new
    end
  end
  

  private

  def require_admin
    if !current_user.admin?
      flash[:error] = "You need to be authorized to do that"
      redirect_to home_path unless current_user.admin?
    end
  end

  def video_params
    params.require(:video).permit(:title, :description, :category_id)
  end

end