class SessionsController < ApplicationController
  def create
    user = User.where(email: params[:email]).first
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to home_path, notice: 'You are signed in, enjoy!'
    else
      flash[:error] = "Invalid email or password"
      redirect_to login_path
    end
  end

  def destroy
    session[params[:user_id]] = nil
    redirect_to root_path, notice: "You are signed out."
  end


end
