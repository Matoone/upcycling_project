class Shop < ApplicationRecord
  belongs_to :maker
  has_many :items
  has_many :orders
  has_many :customers, through: :orders
end
