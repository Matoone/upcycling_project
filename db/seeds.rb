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
fashion_category = Category.create!(name: "Mode")
home_category = Category.create!(name: "Maison")
lifestyle_category = Category.create!(name: "Vie Quotidienne")
child_category = Category.create!(name: "Enfant")

realNames = [{:first_name => "Marc", :last_name => "Dutrot"}, {:first_name => "Jean", :last_name => "Maljean"}, {:first_name => "Sigmund", :last_name => "Friend"}]
realAddresses = [{:address_line_1 => "14 Rue Jarente", :zip_code => "69002", :city => "Lyon"}, {:address_line_1 => "31 rue du Boeuf", :zip_code => "69005", :city => "Lyon"}, {:address_line_1 => "19 Rue Verlet Hanus", :zip_code => "69003", :city => "Lyon"}]
realDescriptions = ["Travailleur du cuir et maroquinier depuis 20 ans, j'ai décidé d'adhérer à la démarche de l'upcycling. A très vite sur mon shop !", "Je suis un fabricant de chaussures expérimenté et habile qui prend son métier à coeur.", "Ancien banquier, j'ai tout plaqué pour me reconvertir dans la fabrication d'objets revalorisés."]
realShopNames = ["Dutrot & Co", "Gémal Opié Shop", "Trendy Shop"]


puts "Create test users with customer and maker, shop and items..."
3.times do |i|
  user = User.create!(email: Faker::Internet.email, password: "password", password_confirmation: "password")
  user_maker = Maker.create!(user: user, description: realDescriptions[i] )
  shop =  Shop.create!(maker: user.maker, name: realShopNames[i])
  customer_address = Address.create!(first_name: realNames[i][:first_name], last_name: realNames[i][:last_name], address_line_1: realAddresses[i][:address_line_1], zip_code: realAddresses[i][:zip_code], city: realAddresses[i][:city], customer: user.customer)
  maker_address = Address.create!(first_name: realNames[i][:first_name], last_name: realNames[i][:last_name], address_line_1: realAddresses[i][:address_line_1], zip_code: realAddresses[i][:zip_code], city: realAddresses[i][:city], maker: user.maker)

  10.times do
    item = Item.create!(name: Faker::Commerce.product_name, description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false), price: Faker::Commerce.price(range: 1..70.0), available_quantity: Faker::Number.within(range: 1..10), shop: shop, category: Category.all.sample)
  end
end


puts "Create test user: you can connect with him with email: test@yopmail.com and password: azerty"
user = User.create!(email: "test@yopmail.com", password: "azerty", password_confirmation: "azerty", is_admin: true)


Maker.all.each do |maker|
  maker.is_validated = true
  maker.save
end

