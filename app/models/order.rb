class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items
  validates_presence_of :user
end
