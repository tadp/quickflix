class UsersController < ApplicationController
  before_filter :require_user, only: [:show]
 def new
   @user = User.new
 end

 def create
  @user = User.new(user_params)
  body = "Welcome"
  if @user.save
    handle_invitation
	  AppMailer.delay.send_welcome_email(@user,body)
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

# mod 9.2 37:00
  def new_with_invitation_token
    invitation = Invitation.where(token: params[:token]).first
    if invitation
      @user = User.new(email: invitation.recipient_email)
      @invitation_token = params[:token]
      render :new
    else
      redirect_to expired_token_path
    end
  end


private
  def user_params
    params.require(:user).permit(:email, :password, :full_name)
  end

  def handle_invitation
    if params[:invitation_token].present?
    invitation = Invitation.where(token: params[:invitation_token]).first
    @user.follow(invitation.inviter)
    invitation.inviter.follow(@user)
    invitation.update_column(:token, nil)
    end
  end


end
