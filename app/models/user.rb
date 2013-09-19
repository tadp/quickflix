class User < ActiveRecord::Base
  has_many :reviews
  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email
  validates :password, confirmation: false
  has_secure_password validations: false
end