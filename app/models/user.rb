class User < ActiveRecord::Base
  has_many :reviews
  has_many :queue_items, order: :list_order
  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email
  validates :password, confirmation: false
  has_secure_password validations: false

  def reorder_queue_items
    queue_items.each_with_index do |queue_item,index|
      queue_item.update_attributes(list_order: index + 1)
    end
  end

end