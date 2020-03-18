class Customer < ApplicationRecord
  belongs_to :user
  has_one :address
  # has_one :cart, dependent: :destroy
  # has_many :orders
end
