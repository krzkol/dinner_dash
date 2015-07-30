FactoryGirl.define do
  factory :order_item do
    item
    item_group { Cart.create }
  end
end
