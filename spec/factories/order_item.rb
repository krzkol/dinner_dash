FactoryGirl.define do
  factory :order_item do
    quantity 1
    item
    item_group { Cart.create }
  end
end
