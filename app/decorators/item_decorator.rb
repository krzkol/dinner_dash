class ItemDecorator < Draper::Decorator
  delegate_all
  decorates_finders

  def price
    helpers.number_to_currency(object.price, precision: 2)
  end
end
