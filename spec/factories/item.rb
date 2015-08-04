FactoryGirl.define do
  factory :item do
    sequence(:title) {|n| "Cheese#{n}burger" }
    description 'Burger with lot of cheese'
    price 2.50
    after(:build) do |item|
      item.categories << build(:category)
    end
  end

  trait :retired do
    retired true
  end
end
