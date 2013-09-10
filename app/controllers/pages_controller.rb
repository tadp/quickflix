class PagesController < ApplicationController
  # This can be empty because Rails will render the view template by convention
  # def front
  # end
  def front
    redirect_to home_path if current_user
  end
end
