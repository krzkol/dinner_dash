class OrderItemsController < ApplicationController
  before_action :set_item
  before_action :set_cart

  def create
    @order_item = OrderItem.new(quantity: 1, item: @item, cart: @cart, price: @item.price)
    if @order_item.save
      flash[:success] = "Added #{@item.title} to cart."
      redirect_to root_path
    else
      flash[:danger] = 'Could not add item to cart.'
      redirect_to root_path
    end
  end

  private
    def set_cart
      if session[:cart_id]
        @cart = Cart.find(session[:cart_id])
      else
        @cart = Cart.create
        session[:cart_id] = @cart.id
      end
    end

    def set_item
      @item = Item.find(params[:item_id])
    rescue ActiveRecord::RecordNotFound
      flash[:danger] = 'Could not find item with given id'
      redirect_to root_path
    end
end
