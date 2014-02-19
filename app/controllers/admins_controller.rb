class AdminsController < AuthenticatedController
  before_filter :require_admin

  private
  def require_admin
    unless current_user.admin?
      flash[:error] = "You need to be authorized to do that"
      redirect_to home_path
    end
  end

end