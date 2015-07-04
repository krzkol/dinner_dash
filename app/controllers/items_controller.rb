class ItemsController < ApplicationController
  before_action :find_cart

  def index
    @items = Item.all
  end

  private
    def find_cart
      if session[:cart_id]
        @cart = Cart.find(session[:cart_id])
      end
    end
end
