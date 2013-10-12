class GenerateTokensForExistingUsers < ActiveRecord::Migration
  def change
    User.all.each do |user|
      # update_column will bypass validation. mod 8.4 24:24
      user.update_column(:token, SecureRandom.urlsafe_base64)
    end
  end
end
