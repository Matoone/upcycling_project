class Maker < ApplicationRecord


  belongs_to :user
  has_one :address, dependent: :destroy
  has_one :shop, dependent: :destroy


end
