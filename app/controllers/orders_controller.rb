class OrdersController < ApplicationController
  before_action :find_cart

  def new
  end

  def create
    order = Order.new
    order.user = current_user
    order.copy_items_from_cart(@cart)
    if order.save
      flash[:success] = "Successfully created order"
      redirect_to root_path
    else
      flash[:danger] = "Could not create an order"
      redirect_to root_path
    end
  end
end
