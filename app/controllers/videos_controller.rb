class VideosController < ApplicationController
  before_action :set_video, only: [:index, :home, :show]

  def index
  end

  def create
  end

  def register
  end

  def sign_in
  end
  

  def home
    @categories=Category.all  
    @video_results=Video.search_by_title(params[:search])
  end

  def show
    @video=Video.find(params[:id])
  end

  private

  def set_video
    @videos=Video.all
  end

end
