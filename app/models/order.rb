class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items, as: :item_group
  validates_presence_of :user
  validates :order_items, length: { minimum: 1 }
end
