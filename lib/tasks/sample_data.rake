# rake db:populate
namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_items
  end
end

def make_users
  User.create!(name: "Biff Biffington",
               email: "biff@email.com",
               password: "biffbiff",
               password_confirmation: "biffbiff")
  User.create!(name: "Stu Stuington",
               email: "stu@email.com",
               password: "stustu",
               password_confirmation: "stustu")
end

def make_items
  users = User.all
  users.each do |user|
    10.times do |n|
      name = Faker::Lorem.words(2).join(" ")
      description = Faker::Lorem.sentence(2)
      price  = rand(99) + rand().round(2)
      user.items.create!(name: name, description: description, price: price)
    end
  end
end
