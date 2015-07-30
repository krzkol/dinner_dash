class Item < ActiveRecord::Base
  has_many :category_items
  has_many :categories, through: :category_items
  has_many :order_items

  def self.items_in_menu
    Item.where(retired: false)
  end
end
