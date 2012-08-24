namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_items
  end
end

def make_items
  10.times do |n|
    name = Faker::Lorem.words(2).join(" ")
    description = Faker::Lorem.sentence(2)
    price  = rand(99) + rand().round(2)
    Item.create!(name: name, description: description, price: price)
  end
end
