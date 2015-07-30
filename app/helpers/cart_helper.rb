module CartHelper
  def cart_has_items?
    !!(@cart && @cart.order_items.size > 0)
  end

  def find_cart
      @cart = Cart.find(session[:cart_id]) if session[:cart_id]
  end
end
