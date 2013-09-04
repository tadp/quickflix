class VideosController < ApplicationController
  before_action :set_video, only: [:index, :home, :show]

  def index
  end

  def home
    @comedy= Category.find_by name: 'Comedy'
    @action= Category.find_by name: 'Action'
    @drama= Category.find_by name: 'Drama'

  end

  def show
    @video=Video.find(params[:id])
  end

  private
  def set_video
    @videos=Video.all
  end

end
