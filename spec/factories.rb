FactoryGirl.define do
  factory :item do
    name  "iPod 8GB"
    description "A brand new iPod still in box"
    price "99.99"
  end

  factory :user do
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
  end
end