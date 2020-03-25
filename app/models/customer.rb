class Customer < ApplicationRecord
  after_create do
    create_customer_cart
  end
  belongs_to :user
  has_one :address
  has_one :cart, dependent: :destroy
  # has_many :orders

  def is_own_identity(customer_id)
    if customer_id != self.id
      return false
    else
      return true
    end
  end

  private

  def create_customer_cart
    cart = Cart.create(customer: self)
    puts "Cart created id #{cart.id}"
  end

 

end
