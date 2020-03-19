class Item < ApplicationRecord
  belongs_to :category
  belongs_to :shop
  has_many :cart_items
  has_many :carts, through: :cart_items
  # has_many :orders_items
  # has_many :orders, through: :orders_items

  def decrement_available_quantity(quantity = 1)
    self.available_quantity -= quantity
    self.save
  end

  def increment_available_quantity(quantity = 1)
    self.available_quantity += quantity
    self.save
  end
end
