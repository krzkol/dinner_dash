class OrderItemDecorator < Draper::Decorator
  delegate_all

  def price
    helpers.number_to_currency(object.price, precision: 2)
  end

  def total
    helpers.number_to_currency(object.total, precision: 2)
  end
end
