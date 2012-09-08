FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
  end

  factory :item do
    sequence(:name) { |n| "iPod #{n}GB" }
    description "A brand new iPod still in box"
    price "99.99"
    user
  end
end