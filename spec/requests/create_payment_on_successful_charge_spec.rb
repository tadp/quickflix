require 'spec_helper'

describe "Create payment on successful charge" do
  let(:event_data) do
    {
  "id" => "evt_102wnS2RG5h2YQBOkaPc5W7Q",
  "created" => 1384549862,
  "livemode" => false,
  "type" => "customer.created",
  "data" => {
    "object" => {
      "object" => "customer",
      "created" => 1384549861,
      "id" => "cus_2wnSCR8RTaVr7r",
      "livemode" => false,
      "description" => nil,
      "email" => "johndoe2@example.com",
      "delinquent" => false,
      "metadata" => {
      },
      "subscription" => {
        "id" => "sub_2wnS5c6zJBHk6M",
        "plan" => {
          "interval" => "month",
          "name" => "The Standard Plan",
          "amount" => 999,
          "currency" => "usd",
          "id" => "standard",
          "object" => "plan",
          "livemode" => false,
          "interval_count" => 1,
          "trial_period_days" => nil,
          "metadata" => {
          }
        },
        "object" => "subscription",
        "start" => 1384549861,
        "status" => "active",
        "customer" => "cus_2wnSCR8RTaVr7r",
        "cancel_at_period_end" => false,
        "current_period_start" => 1384549861,
        "current_period_end" => 1387141861,
        "ended_at" => nil,
        "trial_start" => nil,
        "trial_end" => nil,
        "canceled_at" => nil,
        "quantity" => 1,
        "application_fee_percent" => nil
      },
      "discount" => nil,
      "account_balance" => 0,
      "cards" => {
        "object" => "list",
        "count" => 1,
        "url" => "/v1/customers/cus_2wnSCR8RTaVr7r/cards",
        "data" => [
          {
            "id" => "card_102wnS2RG5h2YQBOx0z8JjXB",
            "object" => "card",
            "last4" => "4242",
            "type" => "Visa",
            "exp_month" => 11,
            "exp_year" => 2015,
            "fingerprint" => "s8iT9BUR4LQPxvYs",
            "customer" => "cus_2wnSCR8RTaVr7r",
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
          }
        ]
      },
      "default_card" => "card_102wnS2RG5h2YQBOx0z8JjXB"
    }
  },
  "object" => "event",
  "pending_webhooks" => 1,
  "request" => "iar_2wnSh6vFvPC69Z"
}
  end

  it "creates a payment with the webhook from stripe for charge succeeded", :vcr do
    post "/stripe_events", event_data
    expect(Payment.count).to eq(1)
  end

  it "creates the payment associated with user", :vcr do
    alice = Fabricate(:user, customer_token: 'cus_2wnSCR8RTaVr7r')
    post "/stripe_events", event_data
    expect(Payment.first.user).to eq(alice)
  end

  it "creates the payment with the amount", :vcr do
    alice = Fabricate(:user, customer_token: 'cus_2wnSCR8RTaVr7r')
    post "/stripe_events", event_data
    expect(Payment.first.amount).to eq(999)
  end

  it "creates the payment with reference id", :vcr do
    alice = Fabricate(:user, customer_token: 'cus_2wnSCR8RTaVr7r')
    post "/stripe_events", event_data
    expect(Payment.first.reference_id).to eq('sub_2wnS5c6zJBHk6M')
  end

end