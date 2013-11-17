class AdminsController < ApplicationController
  before_filter :require_admin

  private
  def require_admin
    if !current_user.admin?
      flash[:error] = "You need to be authorized to do that"
      redirect_to home_path unless current_user.admin?
    end
  end
end