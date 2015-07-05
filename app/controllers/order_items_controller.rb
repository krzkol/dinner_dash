class OrderItemsController < ApplicationController
  before_action :set_item, only: :create
  before_action :set_cart

  def create
    @order_item = @cart.add_item(@item.id)
    if @order_item.save
      flash[:success] = "Added #{@item.title} to cart."
    else
      flash[:danger] = 'Could not add item to cart.'
    end
    redirect_to root_path
  end

  def update
    @order_item = OrderItem.find(params[:id])
    if @order_item.update(order_item_params)
      flash[:success] = "Quantity of item successfully updated."
    else
      flash[:danger] = "Could not update item."
    end
    redirect_to root_path
  end

  def destroy
    @order_item = OrderItem.find(params[:id])
    @order_item.destroy
    flash[:success] = 'You successfully deleted item from your cart.'
    redirect_to root_path
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

    def order_item_params
      params.require(:order_item).permit(:quantity)
    end
end
