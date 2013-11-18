class Admin::PaymentsController < AdminsController
  def index
    #never want to do all in a real application. This is for simplicity.
    @payments = Payment.all
  end
end