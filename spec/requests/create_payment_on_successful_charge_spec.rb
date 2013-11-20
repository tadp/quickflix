require 'spec_helper'

describe "Create payment on successful charge", :vcr do
  let(:event_data) do
{
  "id" => "evt_102xfU2RG5h2YQBO07rf5IK1",
  "created" => 1384750844,
  "livemode" => false,
  "type" => "charge.succeeded",
  "data" => {
    "object" => {
      "id" => "ch_102xfU2RG5h2YQBOvR97do3h",
      "object" => "charge",
      "created" => 1384750844,
      "livemode" => false,
      "paid" => true,
      "amount" => 999,
      "currency" => "usd",
      "refunded" => false,
      "card" => {
        "id" => "card_102xfU2RG5h2YQBOJV5KzNQ4",
        "object" => "card",
        "last4" => "4242",
        "type" => "Visa",
        "exp_month" => 10,
        "exp_year" => 2014,
        "fingerprint" => "s8iT9BUR4LQPxvYs",
        "customer" => "cus_2xfUxJLI6oZ0XG",
        "country" => "US",
        "name" => nil,
        "address_line1" => nil,
        "address_line2" => nil,
        "address_city" => nil,
        "address_state" => nil,
        "address_zip" => nil,
        "address_country" => nil,
        "cvc_check" => "pass",
        "address_line1_check" => nil,
        "address_zip_check" => nil
      },
      "captured" => true,
      "refunds" => [],
      "balance_transaction" => "txn_102xfU2RG5h2YQBOQfp0Eqx8",
      "failure_message" => nil,
      "failure_code" => nil,
      "amount_refunded" => 0,
      "customer" => "cus_2xfUxJLI6oZ0XG",
      "invoice" => "in_102xfU2RG5h2YQBOJJdsnjMf",
      "description" => nil,
      "dispute" => nil,
      "metadata" => {}
    }
  },
  "object" => "event",
  "pending_webhooks" => 1,
  "request" => "iar_2xfUZcPj9xCokp"
}
  end

  it "creates a payment with the webhook from stripe for charge succeeded", :vcr do
    post "/stripe_events", event_data
    expect(Payment.count).to eq(1)
  end

  it "creates the payment associated with user", :vcr do
    alice = Fabricate(:user, customer_token: 'cus_2xfUxJLI6oZ0XG')
    post "/stripe_events", event_data
    expect(Payment.first.user).to eq(alice)
  end

  it "creates the payment with the amount", :vcr do
    alice = Fabricate(:user, customer_token: 'cus_2xfUxJLI6oZ0XG')
    post "/stripe_events", event_data
    expect(Payment.first.amount).to eq(999)
  end

  it "creates the payment with reference id", :vcr do
    alice = Fabricate(:user, customer_token: 'cus_2xfUxJLI6oZ0XG')
    post "/stripe_events", event_data
    expect(Payment.first.reference_id).to eq('ch_102xfU2RG5h2YQBOvR97do3h')
  end

end
