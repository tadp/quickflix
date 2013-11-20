class UsersController < ApplicationController
  before_filter :require_user, only: [:show]
 def new
   @user = User.new
 end

 def create
  @user = User.new(user_params)
  result = UserSignup.new(@user).sign_up(params[:stripeToken], params[:invitation_token])
  if result.successful?
    flash[:success] = "Thank you for registering with us. Please sign in now"
    redirect_to login_path
  else
    flash[:error] = result.error_message
    render :new
  end
 end

 def edit
  @user = User.find(params[:id])
 end

 def update
  @user = User.find(params[:id])
  if @user.update(update_params)
    redirect_to root_path
    flash[:success] = "You successfully updated your details."
  else
    flash[:error] = "There were errors when updating."
    render 'edit'
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

  def update_params
    params.require(:user).permit(:email, :password, :full_name)
  end

  def user_params
    params.require(:user).permit(:email, :password, :full_name, :stripeToken,:invitation_token)
  end

end
