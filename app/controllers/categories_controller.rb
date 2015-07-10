class CategoriesController < ApplicationController
  before_action :find_cart
  
  def show
    @category = Category.find(params[:id])
  end
end
