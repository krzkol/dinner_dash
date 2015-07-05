module CartHelper
  def cart_has_items?
    !!(@cart && @cart.order_items.size > 0)
  end
end
