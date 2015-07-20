class OrderItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :item_group, polymorphic: true
  validates_presence_of :item, :item_group
end
