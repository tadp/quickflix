class Admin::VideosController < ApplicationController
  before_filter :require_user
  before_filter :require_admin

  def new
    @videos = Video.new
  end

  private

  def require_admin
    if !current_user.admin?
      flash[:error] = "You need to be authorized to do that"
      redirect_to home_path unless current_user.admin?
    end
  end
end