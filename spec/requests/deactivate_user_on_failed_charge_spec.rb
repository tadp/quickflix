require 'spec_helper'

describe "Deactivate user on failed charge", :vcr do
  let(:event_data) do
{
  "id" => "evt_102xpP2RG5h2YQBOFgrjS4uq",
  "created" => 1384787733,
  "livemode" => false,
  "type" => "charge.failed",
  "data" => {
    "object" => {
      "id" => "ch_102xpP2RG5h2YQBOV64j7On3",
      "object" => "charge",
      "created" => 1384787733,
      "livemode" => false,
      "paid" => false,
      "amount" => 999,
      "currency" => "usd",
      "refunded" => false,
      "card" => {
        "id" => "card_102xpN2RG5h2YQBOQDpdrIHG",
        "object" => "card",
        "last4" => "0341",
        "type" => "Visa",
        "exp_month" => 11,
        "exp_year" => 2016,
        "fingerprint" => "goDNf16CnFq339sA",
        "customer" => "cus_2xozO3FtDOvL5h",
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
      "captured" => false,
      "refunds" => [],
      "balance_transaction" => nil,
      "failure_message" => "Your card was declined.",
      "failure_code" => "card_declined",
      "amount_refunded" => 0,
      "customer" => "cus_2xozO3FtDOvL5h",
      "invoice" => nil,
      "description" => "Test failed charge",
      "dispute" => nil,
      "metadata" => {}
    }
  },
  "object" => "event",
  "pending_webhooks" => 1,
  "request" => "iar_2xpP0vZkPuVGYI"
}
  end

  it "deactivates a user with the web hook data from stripe for charge failed", :vcr do
    alice = Fabricate(:user, customer_token: "cus_2xozO3FtDOvL5h")
    post "/stripe_events", event_data
    expect(alice.reload).not_to be_active
  end


end
