FactoryGirl.define do
  factory :order do
    user
    after(:build) do |order|
      order.order_items << build(:order_item)
    end
  end

  trait :paid do
    status 'paid'
  end

  trait :completed do
    status 'completed'
  end

  trait :cancelled do 
    status 'cancelled'
  end
end
