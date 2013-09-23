class User < ActiveRecord::Base
  has_many :reviews
  has_many :queue_items
  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email
  validates :password, confirmation: false
  has_secure_password validations: false

  def reorder
    list_order = 1
    queue_items.each do |queue_item|
      queue_item.update(list_order: list_order)
      list_order += 1
    end
  end

end