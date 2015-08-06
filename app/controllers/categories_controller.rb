class CategoriesController < ApplicationController
  before_action :find_cart
  before_action :authenticate_user, except: :show
  before_action :check_user_type, except: :show

  def show
    @category = Category.find(params[:id])
    @items = ItemDecorator.decorate_collection(@category.items)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = 'Successfully created category'
      redirect_to @category
    else
      flash[:danger] = 'Could not create a category'
      render 'new'
    end
  end

  private
    def category_params
      params.require(:category).permit(:name)
    end
end
