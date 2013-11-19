Stripe.api_key = ENV['STRIPE_SECRET_KEY']

StripeEvent.setup do
  subscribe 'charge.succeeded' do |event|
    user = User.where(customer_token: event.data.object.customer).first
    Payment.create(user: user, amount: event.data.object.amount, reference_id: event.data.object.id, period_start: event.created, period_end: event.created + (4*7*24*60*60), paid: event.data.object.paid )
  end

  subscribe 'charge.failed' do |event|
    user = User.where(customer_token: event.data.object.customer).first
    user.deactivate!
    AppMailer.payment_failed(user).deliver
  end
end