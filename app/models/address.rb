class Address < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address_line_2, presence: true
  validates :city, presence: true
  validates :zip_code, presence: true, format: { with: /\A(([0-8][0-9])|(9[0-5])|(2[ab]))[0-9]{3}\z/, message: "Vous devez saisir un code postal français valide." }
  belongs_to :maker, optional: true
  belongs_to :customer, optional: true
end
