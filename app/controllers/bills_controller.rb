class BillsController< AuthenticatedController
  def index
    @customer = current_user
    @payments = Payment.where(user_id: current_user.id)
  end

  def destroy
    customer_token = current_user.customer_token
    StripeWrapper::Customer.destroy(customer_token: customer_token)
    flash[:success] = "Your service has been canceled."
    redirect_to payments_path
  end
end