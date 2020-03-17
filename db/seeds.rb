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

puts "Create test user with customer and maker..."
test_user = User.create!(email: 'test@example.com', password: "password", password_confirmation: "password")
test_customer = Customer.create!(user: test_user)
test_maker = Maker.create!(user: test_user, first_name: "Jean", last_name: "Bon", description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false) )
puts "  Done. Use 'test@example.com' as login and 'password' as password"
puts "Create test user with only customer"
test_user_2 = User.create!(email: 'test2@example.com', password: "password", password_confirmation: "password")
test_customer_2 = Customer.create!(user: test_user_2)
puts "  Done. Use 'test2@example.com' as login and 'password' as password"