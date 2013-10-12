class AppMailer < ActionMailer::Base
	def send_welcome_email(user,body=nil)
    @user = user
    @body = body
		mail from: "info@myflix.com", to: user.email, subject: "You just registered!"
	end

  def send_forgot_password(user)
    @user = user
    mail from: "info@myflix.com", to: user.email, subject: "Please reset your password"
  end
end
