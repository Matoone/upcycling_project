# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "faker"
puts "Destroy all users..."
User.destroy_all
puts "Users destroyed"
Maker.destroy_all
puts "Makers destroyed"
Customer.destroy_all
puts "Customers detroyed"
Item.destroy_all
puts "Items destroyed"
Shop.destroy_all
puts "Shops destroyed"

puts "Create test user with customer and maker..."
user_1 = User.create!(email: 'test@example.com', password: "password", password_confirmation: "password")
user_1_customer = Customer.create!(user: user_1)
user_1_maker = Maker.create!(user: user_1, first_name: "Jean", last_name: "Bon", description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false) )
puts "Done. Use 'test@example.com' as login and 'password' as password"

puts "Setting address to user_1_customer..."
user_1_address = Address.create!(street_number: "42", address_line_1: "rue des gros vilains", zip_code: "69100", city: "Lyon", customer: user_1.customer)
puts "Setting address to user_1_maker"
user_2_address = Address.create!(address_line_1: "La Bouillonnaise", zip_code: "34540", city: "Bouilloux", maker: user_1.maker)
puts "Creating test user with only customer..."
user_2 = User.create!(email: 'test2@example.com', password: "password", password_confirmation: "password")
user_2_customer = Customer.create!(user: user_2)
puts "Done. Use 'test2@example.com' as login and 'password' as password"
puts "Creating test user_maker_shop and populating a few categories and items..."
user_1_maker_shop = Shop.create!(maker: user_1_maker)

grocery_category = Category.create!(name: "Epicerie")
decoration_category = Category.create!(name: "Décoration")
bathroom_category = Category.create!(name: "Salle de bain")

ecological_toothbrush = Item.create!(name: "Brosse à dents écologique", description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false), price: 4.2, available_quantity: 5, shop: user_1_maker_shop, category: bathroom_category)
biologic_tisane = Item.create!(name: "Tisane biologique des elfes", description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false), price: 7, available_quantity: 15, shop: user_1_maker_shop, category: grocery_category)
handmade_statue = Item.create!(name: "Statue décorative faite à la main", description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false), price: 35, available_quantity: 1, shop: user_1_maker_shop, category: decoration_category)

puts "Shop created and populated."

