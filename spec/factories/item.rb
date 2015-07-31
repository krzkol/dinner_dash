FactoryGirl.define do
  factory :item do
    title 'Cheeseburger'
    description 'Burger with lot of cheese'
    price 2.50
  end

  trait :retired do
    retired true
  end
end
