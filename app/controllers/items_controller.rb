class ItemsController < ApplicationController
  before_action :find_cart

  def index
    @items = Item.all
  end
end
