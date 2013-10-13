module Tokenable
  extend ActiveSupport::Concern

  included do
    before_create :generate_token
  end


  def generate_token
    self.token = SecureRandom.urlsafe_base64(n=5)
  end

end