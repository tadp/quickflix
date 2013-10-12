class User < ActiveRecord::Base
  has_many :reviews, order: "created_at DESC"
  has_many :queue_items, order: :list_order
  #Mod7.2 12:00
  has_many :following_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :leading_relationships, class_name: "Relationship", foreign_key: :leader_id


  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email
  validates_format_of :email, :with => /.+@.+\..+/i
  validates :password, confirmation: false
  has_secure_password validations: false

  before_create :generate_token

  def reorder_queue_items
    queue_items.each_with_index do |queue_item,index|
      queue_item.update_attributes(list_order: index + 1)
    end
  end

  def queued_video?(video)
    queue_items.map(&:video).include?(video)
  end

  def follows?(another_user)
    following_relationships.map(&:leader).include?(another_user)
  end

  def can_follow?(another_user)
    !(follows?(another_user) || self == another_user)
  end

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end

end