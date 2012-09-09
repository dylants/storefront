FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
  end

  factory :item do
    sequence(:name) { |n| "Taco Thing ##{n}" }
    item_type ["Taco", "Hot Sauce", "Chips"].sample
    description "A really tasty taco thingamagig"
    price "3.99"
    user
  end
end