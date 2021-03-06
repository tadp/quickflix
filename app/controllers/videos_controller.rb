class VideosController < ApplicationController
  before_action :set_video, only: [:index, :home, :show]
  before_filter :require_user

  def index
    @categories=Category.all  
    @video_results=Video.search_by_title(params[:search_term])
  end

  def show
    @video=VideoDecorator.decorate(Video.find(params[:id]))
    @reviews= @video.reviews
  end

  def search
    @video_results = Video.search_by_title(params[:search_term])
  end

  private

  def set_video
    @videos=Video.all
  end

end
