class Cart < ApplicationRecord
  
  has_many :cart_items
  has_many :items, through: :cart_items
  belongs_to :customer, optional: true # optional true to then be able to have guest cart
end
