class ItemsController < ApplicationController
  before_action :find_cart
  before_action :authenticate_user, except: [:index, :show]
  before_action :check_user_type, except: [:index, :show]

  def index
    items = Item.all
    @items = ItemDecorator.decorate_collection(items)
  end

  def show
    @item = ItemDecorator.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:success] = 'Successfully created item!'
      redirect_to @item
    else
      flash[:danger] = 'Could not create an item'
      render 'new'
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:success] = 'Successfully updated item!'
      redirect_to @item
    else
      flash[:danger] = 'Could not update item'
      render 'edit'
    end
  end

  private
    def item_params
      params.require(:item).permit(:title, :description, :price, :image)
    end

    def check_user_type
      unless current_user.admin?
        flash[:danger] = 'Sorry you must be admin to access this page'
        redirect_to items_path
      end
    end
end
