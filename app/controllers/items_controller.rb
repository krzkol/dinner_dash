class ItemsController < ApplicationController
  before_action :find_cart

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

  private
    def item_params
      params.require(:item).permit(:title, :description, :price)
    end
end
