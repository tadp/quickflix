module StripeWrapper
  class Charge
    attr_reader :error_message, :response

    def initialize(options={})
      @response = options[:response]
      @error_message = options[:error_message]
    end

    def self.create(options={})
      begin
        response = Stripe::Charge.create(
          amount: options[:amount],
          currency: 'usd',
          card: options[:card],
          description: options[:description]
          )
        new(options[:response] = response)
      rescue Stripe::CardError => e
        new(options[:error_message] = e.message)
        # named arguments only work in Ruby 2.0
        # new(error_message: e.message)
      end
    end

    def successful?
      response.present?
    end

  end
end
