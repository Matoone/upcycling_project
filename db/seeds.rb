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

puts "Create test user..."
test_user = User.create!(email: 'test@example.com', password: "password", password_confirmation: "password")
test_customer = Customer.create!(user: test_user)
puts "  Done. Use 'test@example.com' as login and 'password' as password"