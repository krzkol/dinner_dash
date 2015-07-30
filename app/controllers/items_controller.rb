class ItemsController < ApplicationController
  before_action :find_cart

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end
end
