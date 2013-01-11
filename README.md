# Storefront #

Welcome to the Taco Trade!

## Overview ##

This application acts as a store front for a Taco Trade online restaurant. In it, a user can both
buy and sell tacos, hot sauces, and chips. Once an item has been purchased, it moves to the buyer's
items purchased and to the seller's items sold. All of this can be retrieved from the Dashboard,
which is accessible to any logged in user. This application also provides a search functionality to
search for various items within the store.

## Technical Implementation Details ##

This is a Ruby Rails application, based on three main models: Item, Order, and User. Each Item has
a name, description, price, and type. Its within the type that the Item is distinguished from a taco,
hot sauce, or chips. Each Item also has a user_id to associate who created or listed the Item on the
store. Each Item has one Order, and belongs to one User.

When an Item is purchased, an Order is created which links the buyer, seller, and item. Each Order
belongs to one buyer (User), one seller (User), and one Item. The Order is really there just to
provide a link to keep track of the transaction.

A User represents a registered user within the store. Devise is used to provide authentication,
registration, remember me, and a few other minor things. Each User has zero to many of each:
items (Item), orders sold (Order), items sold (Item), orders purchased (Order), and items purchased
(Item). Most of this information is gathered from use of the Order.

Twitter's Bootstrap has been used in part for the views, and this application takes advantage of the
responsive design available through Bootstrap. As mentioned earlier, Devise is used for security
(authentication and authorization) for page views. Elasticsearch is used to provide search functionality,
and is wired in to scan items entered into the database via the Tire ruby gem.

Most of the application was written using test driven development, using RSpec and Capybara. Some
setup/tear down for the tests was done using factory_girl and database cleaner.

## Getting Started ##

As with any Rails application, once you've cloned the repo, simply perform bundle install to install
all the bundled needed. After that use rake to create and migrate the database. Then start the rails
server. Also know some sample data has been provided as part of a rake task, running "rake db:populate"
should pre-populate the database with two users and a ton of items to buy/sell.
