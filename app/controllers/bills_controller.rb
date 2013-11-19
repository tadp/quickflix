class BillsController< AuthenticatedController
  def index
    @customer = current_user
    @payments = Payment.all
  end
end