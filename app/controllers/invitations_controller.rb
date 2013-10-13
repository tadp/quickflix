class InvitationsController < ApplicationController
  before_filter :require_user

  def new
    @invitation = Invitation.new
  end

  def create
    # @friend = User.new(user_params)
    # body = "This is a body for invite email"
    # AppMailer.send_invite_email(user).deliver
    # flash[:success] = "Invite successfully sent!"

    @invitation = Invitation.new(invite_params.merge!(inviter_id: current_user.id))
    if @invitation.save
      AppMailer.send_invitation_email(@invitation).deliver
      flash[:success] = "You have successfully invited #{@invitation.recipient_name}."
      redirect_to new_invitation_path
    else
      flash[:error] = "Please check your inputs"
      render :new
    end
  end


 private
  def invite_params
    params.require(:invitation).permit(:recipient_name, :recipient_email, :message, :inviter_id)
  end

end