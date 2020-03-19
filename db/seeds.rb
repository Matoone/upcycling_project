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
Cart.destroy_all
puts "Carts destroyed"
CartItem.destroy_all
puts "CartItems destroyed"
Category.destroy_all
puts "Categories destroyed"

puts "Create test user with customer and maker..."
user_1 = User.create!(email: 'test@example.com', password: "password", password_confirmation: "password")

user_1_maker = Maker.create!(user: user_1, description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false) )
puts "Done. Use 'test@example.com' as login and 'password' as password"

puts "Setting address to user_1_customer..."
user_1_address = Address.create!(first_name: "Jean", last_name: "Bon", street_number: "42", address_line_1: "rue des gros vilains", zip_code: "69100", city: "Lyon", customer: user_1.customer)
puts "Setting address to user_1_maker"
user_2_address = Address.create!(first_name: "Paul", last_name: "Mauvais", address_line_1: "La Bouillonnaise", zip_code: "34540", city: "Bouilloux", maker: user_1.maker)
puts "Creating test user with only customer..."
user_2 = User.create!(email: 'test2@example.com', password: "password", password_confirmation: "password")

puts "Done. Use 'test2@example.com' as login and 'password' as password"
puts "Creating test user_maker_shop and populating a few categories and items..."
user_1_maker_shop = Shop.create!(maker: user_1.maker)

grocery_category = Category.create!(name: "Epicerie")
decoration_category = Category.create!(name: "Décoration")
bathroom_category = Category.create!(name: "Salle de bain")

ecological_toothbrush = Item.create!(name: "Brosse à dents écologique", description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false), price: 4.2, available_quantity: 5, shop: user_1_maker_shop, category: bathroom_category)
biologic_tisane = Item.create!(name: "Tisane biologique des elfes", description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false), price: 7, available_quantity: 15, shop: user_1_maker_shop, category: grocery_category)
handmade_statue = Item.create!(name: "Statue décorative faite à la main", description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false), price: 35, available_quantity: 1, shop: user_1_maker_shop, category: decoration_category)
bulk_bags = Item.create!(name: "Sacs à vrac", description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false), price: 30, available_quantity: 3, shop: user_1_maker_shop, category: grocery_category)
coat_rack = Item.create!(name: "Porte manteau", description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false), price: 50, available_quantity: 1, shop: user_1_maker_shop, category: decoration_category)
earrings = Item.create!(name: "Boucle d'oreille", description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false), price: 7, available_quantity: 10, shop: user_1_maker_shop, category: grocery_category)
make_up_remover = Item.create!(name: "Coton démaquillant réutilisable", description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false), price: 2, available_quantity: 25, shop: user_1_maker_shop, category: bathroom_category)
wooden_stick = Item.create!(name: "Baguettes", description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false), price: 6, available_quantity: 4, shop: user_1_maker_shop, category: grocery_category)



puts "Shop created and populated."

puts "Push items into carts"
user_1.customer.cart.items.push(Item.all.last)
user_2.customer.cart.items.push(Item.all.first)
puts "Pushed one item in each cart"
