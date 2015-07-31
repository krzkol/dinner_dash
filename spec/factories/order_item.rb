FactoryGirl.define do
  factory :order_item do
    item
    item_group { Cart.create }
    price 2.00
  end
end
