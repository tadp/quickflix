class CategoriesController < ApplicationController
  def show
    @category=Category.find(params[:id])
  end

private
  def set_category
    @category=Category.find(params[:id])
  end
end