class Customer < ApplicationRecord
  after_create do
    create_customer_cart
  end
  belongs_to :user
  has_one :address
  has_one :cart, dependent: :destroy
  # has_many :orders

  private
  def create_customer_cart
    cart = Cart.create(customer: self)
    puts "Cart created id #{cart.id}"
  end
end
