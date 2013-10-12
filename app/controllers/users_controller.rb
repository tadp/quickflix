class UsersController < ApplicationController
  before_filter :require_user, only: [:show]
 def new
   @user = User.new
 end

 def create
  @user = User.new(user_params)
  body = "This is a body"
  if @user.save
	  AppMailer.send_welcome_email(@user,body).deliver
    flash[:success] = "You just registered!"
    redirect_to login_path
  else
    flash[:error] = @user.errors.full_messages.join(', ')
    render :new
  end
 end

 def show
  @user = User.find(params[:id])
 end

private
  def user_params
    params.require(:user).permit(:email, :password, :full_name)
  end

end
