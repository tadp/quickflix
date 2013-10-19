class Admin::CategoriesController < ApplicationController
  before_filter :require_user
  before_filter :require_admin

  def new
    @category= Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category successfully added"
      redirect_to new_admin_category_path
    else
      flash[:error] = "Unable to add."
      render :new
    end
  end

private
  def require_admin
    if !current_user.admin?
      flash[:error] = "You need to be authorized to do that"
      redirect_to home_path unless current_user.admin?
    end
  end

  def category_params
    params.require(:category).permit(:name)
  end
end