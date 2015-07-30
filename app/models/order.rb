class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items, as: :item_group
  validates_presence_of :user
  validates :order_items, length: { minimum: 1 }

  def copy_items_from_cart(cart)
    cart.order_items.each do |item|
      item.item_group = self
      order_items << item
    end
  end

  def self.find_user_orders(user)
    Order.where(user_id: user.id)
  end
end
