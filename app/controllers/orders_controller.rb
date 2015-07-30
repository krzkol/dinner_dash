class OrdersController < ApplicationController
  before_action :find_cart
  before_action :authenticate_user

  def index
    @orders = Order.find_user_orders(current_user)
  end

  def show
    @order = Order.find(params[:id])
  end

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

  private
    def authenticate_user
      unless user_logged_in?
        flash[:danger] = 'You must be logged in to perform this action'
        redirect_to login_path
      end
    end

    def user_logged_in?
      !!current_user
    end
end
