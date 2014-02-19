class Admin::PaymentsController < AdminsController
  def index
    binding.pry
    @payments = Payment.last(10)
  end
end