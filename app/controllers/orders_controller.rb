class OrdersController < ApplicationController
  before_action :find_cart
  before_action :authenticate_user
  before_action :check_order_owner, only: [:show]

  def index
    unless current_user.admin?
      orders = Order.find_user_orders(current_user)
    else
      orders = Order.all
      @status = params[:status]
      @ordered = OrderDecorator.decorate_collection(Order.where(status: 'ordered'))
      @paid = OrderDecorator.decorate_collection(Order.where(status: 'paid'))
      @completed = OrderDecorator.decorate_collection(Order.where(status: 'completed'))
      @cancelled = OrderDecorator.decorate_collection(Order.where(status: 'cancelled'))
    end
    @orders = OrderDecorator.decorate_collection(orders)
  end

  def new
  end

  def create
    order = Order.new
    order.user = current_user
    order.copy_items_from_cart(@cart)
    if order.save
      flash[:success] = "Successfully created order"
      redirect_to order
    else
      flash[:danger] = "Could not create an order"
      redirect_to root_path
    end
  end

  def update
    @order = Order.find(params[:id])
    if @order.update_attributes(order_params)
      redirect_to orders_path(status: params[:order][:status])
    else
      redirect :back
    end
  end

  private
    def check_order_owner
      @order = OrderDecorator.find(params[:id])
      unless @order.user == current_user || current_user.admin?
        flash[:danger] = 'Only order owner can access this page.'
        redirect_to root_path
      end
    end

    def order_params
      params.require(:order).permit(:status)
    end
end
