class Maker < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true

  belongs_to :user
  has_one :address, dependent: :destroy
  has_one :shop, dependent: :destroy


end
