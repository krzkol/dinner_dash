FactoryGirl.define do
  factory :order do
    user
    after(:build) do |order|
      order.order_items << build(:order_item)
    end
  end
end
