class Video < ActiveRecord::Base
  has_many :reviews, order:"created_at DESC"
  has_many :video_categories
  has_many :categories, through: :video_categories, order: :name
  # validates :title, presence: true
  # validates :description, presence: true
  #refactored:
  validates_presence_of :title, :description


  mount_uploader :large_cover, LargeCoverUploader
  mount_uploader :small_cover, SmallCoverUploader

  def self.search_by_title(search_term)
    if search_term.blank?
      nil
    else
    self.where(["title LIKE :search_term", {:search_term => "%#{search_term}%"}]).order("created_at DESC")
    end

    #   17.2 pluck
    # pluck can be used to query a single or multiple columns from the underlying table of a model. It accepts a list of column names as argument and returns an array of values of the specified columns with the corresponding data type.


    # if search_term
    
    # self.where(["title LIKE :search_term", {:search_term => "%#{search_term}%"}])

    # #Another method but returns an array:
    # # video_obj= self.where("title LIKE :search_term", {:search_term => "%#{search_term}%"}).pluck(:title)
    # # binding.pry

    # else
    # find(:all)
    # end
  end
  
  def average_rating
    sum= reviews.map{ |n| n.rating}.inject(:+)
    average = (sum.to_f / reviews.count).round(1)
  end
end
