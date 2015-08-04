FactoryGirl.define do
  factory :user do
    first_name 'Stephen'
    last_name 'Strange'
    sequence(:email) { |n| "doctor#{n}@strange.com" }
    password 'agamotho'
  end

  trait :admin do
    admin true
  end
end
