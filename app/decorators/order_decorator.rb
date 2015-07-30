class OrderDecorator < Draper::Decorator
  delegate_all
  decorates_association :order_items
  decorates_finders

  def created_at
    object.created_at.strftime("%d %b %Y at %H:%M:%S")
  end

  def updated_at
    object.updated_at.strftime("%d %b %Y at %H:%M:%S")
  end

  def total
    helpers.number_to_currency(object.total, precision: 2)
  end
end
