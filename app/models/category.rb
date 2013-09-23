class Category < ActiveRecord::Base
  has_many :video_categories
  has_many :videos, through: :video_categories, order: :title
  validates_presence_of :name
  def recent_videos
    videos.order("created_at DESC").limit(6)
  end
end
