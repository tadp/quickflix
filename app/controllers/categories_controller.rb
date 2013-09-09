class CategoriesController < ApplicationController
  def index
    @categories=Category.all
  end


private
  def set_category
    @category=Category.find(params[:id])
  end
end