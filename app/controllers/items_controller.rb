class ItemsController < ApplicationController
  before_action :find_cart

  def index
    items = Item.all
    @items = ItemDecorator.decorate_collection(items)
  end

  def show
    @item = ItemDecorator.find(params[:id])
  end
end
