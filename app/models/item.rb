class Item < ApplicationRecord
  belongs_to :category
  belongs_to :shop
  has_many :cart_items
  has_many :carts, through: :cart_items
  # has_many :orders_items
  # has_many :orders, through: :orders_items
end
