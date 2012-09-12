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
  biff = User.find_by_email("biff@email.com")
  make_item("Green Chile Pork", Item.taco, biff)
  make_item("Fried Avocado", Item.taco, biff)
  make_item("Trailer Park", Item.taco, biff)
  make_item("Dirty Sanchez", Item.taco, biff)
  make_item("Baja Shrimp", Item.taco, biff)
  make_item("Chicken Fajita", Item.taco, biff)
  make_item("Beef Fajita", Item.taco, biff)
  make_item("The Democrat", Item.taco, biff)
  make_item("The Republican", Item.taco, biff)
  make_item("The Independent", Item.taco, biff)
  make_item("Brush Fire", Item.taco, biff)
  make_item("Mr. Pink", Item.taco, biff)
  make_item("Mr. Orange", Item.taco, biff)
  make_item("Crossroads", Item.taco, biff)
  make_item("A Little Nukey", Item.hot_sauce, biff)
  make_item("Wasabi Bombs", Item.hot_sauce, biff)
  make_item("Black Mamba", Item.hot_sauce, biff)
  make_item("Death Rain", Item.hot_sauce, biff)
  make_item("Bayou Passion", Item.hot_sauce, biff)
  make_item("Pure Ghost", Item.hot_sauce, biff)
  make_item("Popchips", Item.chips, biff)
  make_item("Catsup Papas", Item.chips, biff)
  make_item("Turbos Flamas", Item.chips, biff)
  make_item("Fuego", Item.chips, biff)

  stu = User.find_by_email("stu@email.com")
  make_item("Cowboy Taco", Item.taco, stu)
  make_item("Tacoloco", Item.taco, stu)
  make_item("Carne Asada", Item.taco, stu)
  make_item("Adobados", Item.taco, stu)
  make_item("Happy Taco", Item.taco, stu)
  make_item("El Conquistador", Item.taco, stu)
  make_item("Al Pastor", Item.taco, stu)
  make_item("Fish Taco", Item.taco, stu)
  make_item("Florentino", Item.taco, stu)
  make_item("Freakin' Vegan", Item.taco, stu)
  make_item("Space Cowboy", Item.taco, stu)
  make_item("Gingery Mango", Item.hot_sauce, stu)
  make_item("Blood Chile", Item.hot_sauce, stu)
  make_item("Mango Meltdown", Item.hot_sauce, stu)
  make_item("Bread and Butter Jalapeno", Item.hot_sauce, stu)
  make_item("Toad Sweat", Item.hot_sauce, stu)
  make_item("Beyond Hot", Item.hot_sauce, stu)
  make_item("Extreme Torchin' Tamale", Item.chips, stu)
  make_item("Queso y Chile", Item.chips, stu)
  make_item("Guacamole", Item.chips, stu)
  make_item("Fried Flour", Item.chips, stu)
  make_item("Crunchy Fajita", Item.chips, stu)
end

def make_item(name, item_type, user)
  description = Faker::Lorem.sentence(5)
  price  = rand(9) + rand().round(2)
  user.items.create!(name: name, item_type: item_type,
                     description: description, price: price)
end
