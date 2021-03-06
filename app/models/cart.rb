class Cart < ActiveRecord::Base
  has_many :order_items, as: :item_group

  def add_item(item_id)
    added_item = order_items.find{ |oi| oi.item_id == item_id}
    if added_item
      added_item.quantity += 1
    else
      added_item = order_items.build(item_id: item_id, price: Item.find(item_id).price)
    end
    added_item
  end
end
