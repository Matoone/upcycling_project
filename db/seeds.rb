# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "faker"
puts "Destroy orders"
OrderItem.destroy_all
Order.destroy_all
puts "Orders destroyed"
puts "Destroy all addresses"
Address.destroy_all
puts "Addresses destroyed"
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

puts "Create a few categories..."
grocery_category = Category.create!(name: "Epicerie")
decoration_category = Category.create!(name: "Décoration")
bathroom_category = Category.create!(name: "Salle de bain")


puts "Create test users with customer and maker, shop and items..."
10.times do |i|
  user = User.create!(email: Faker::Internet.email, password: "password", password_confirmation: "password")
  user_maker = Maker.create!(user: user, description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false) )
  shop =  Shop.create!(maker: user.maker, name: Faker::Commerce.department(max: 3))
  customer_address = Address.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name , street_number: Faker::Number.within(range: 1..150).to_s, address_line_2: "rue " + Faker::Address.street_name, zip_code: "69100", city: Faker::Address.city, customer: user.customer)
  maker_address = Address.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name , street_number: Faker::Number.within(range: 1..150).to_s, address_line_2: "rue " + Faker::Address.street_name, zip_code: "69100", city: Faker::Address.city, maker: user.maker)

  10.times do
    item = Item.create!(name: Faker::Commerce.product_name, description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false), price: Faker::Commerce.price(range: 0..70.0), available_quantity: Faker::Number.within(range: 1..10), shop: shop, category: Category.all.sample)
  end
end

puts "Create test users with customer only..."
30.times do |i|
  user = User.create!(email: Faker::Internet.email, password: "password", password_confirmation: "password")
  customer_address = Address.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, address_line_1: "étage " + i, address_line_2: "rue " + Faker::Address.street_name, street_number: Faker::Number.within(range: 1..150).to_s, zip_code: "69100", city: "Villeurbanne", customer: user.customer)
end


# ecological_toothbrush = Item.create!(name: "Brosse à dents écologique", description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false), price: 4.2, available_quantity: 5, shop: user_1_maker_shop, category: bathroom_category)
# biologic_tisane = Item.create!(name: "Tisane biologique des elfes", description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false), price: 7, available_quantity: 15, shop: user_1_maker_shop, category: grocery_category)
# handmade_statue = Item.create!(name: "Statue décorative faite à la main", description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false), price: 35, available_quantity: 1, shop: user_1_maker_shop, category: decoration_category)
# bulk_bags = Item.create!(name: "Sacs à vrac", description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false), price: 30, available_quantity: 3, shop: user_1_maker_shop, category: grocery_category)
# coat_rack = Item.create!(name: "Porte manteau", description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false), price: 50, available_quantity: 1, shop: user_1_maker_shop, category: decoration_category)
# earrings = Item.create!(name: "Boucle d'oreille", description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false), price: 7, available_quantity: 10, shop: user_1_maker_shop, category: grocery_category)
# make_up_remover = Item.create!(name: "Coton démaquillant réutilisable", description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false), price: 2, available_quantity: 25, shop: user_1_maker_shop, category: bathroom_category)
# wooden_stick = Item.create!(name: "Baguettes", description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false), price: 6, available_quantity: 4, shop: user_1_maker_shop, category: grocery_category)


puts "Push some items into carts"
Customer.all.each do |customer|
  5.times do
    customer.cart.items.push(Item.all.sample)
  end
end
# puts "Create fake order"

#   Order.create!(stripe_customer_id: Faker::Code.imei, customer_id: Customer.all.last.id, shop_id: user_1.maker.shop.id)
#   puts "Done"
