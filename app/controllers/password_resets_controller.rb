class PasswordResetsController < ApplicationController
  def show
    user = User.where(token: params[:id]).first
    if user
      @token = user.token
    else
    redirect_to expired_token_path
    end
  end

  def expired_token
  end

  def create
    user = User.where(token: params[:token]).first
    if user
      user.password = params[:password]
      user.generate_token
      if user.save
        flash[:success] = "Your password has been changed. Please sign in."
        redirect_to login_path
      else
        flash[:error] = "That is not an acceptable password."
        render :show
      end
    else
      redirect_to expired_token_path
    end
  end

end