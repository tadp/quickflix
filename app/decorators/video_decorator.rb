class VideoDecorator < Draper::Decorator
  delegate_all

  def rating
    object.reviews.present? ? "#{object.average_rating}/5.0" : "N/A"
  end
end