class VideosController < ApplicationController
  before_action :set_video, only: [:index, :home, :show]

  def index
  end

  def home
    @categories=Category.all

  end

  def show
    @video=Video.find(params[:id])
  end

  private
  def set_video
    @videos=Video.all
  end

end
