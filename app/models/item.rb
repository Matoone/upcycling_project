class Item < ApplicationRecord
  validates :available_quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, message: "La quantité doit être un nombre entier supérieure ou égale à 0 (valeur actuelle: %{count})" }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0.5, message: "Le prix doit être un nombre supérieur ou égal à 0,5 (valeur actuelle: %{count})" }
  validates :name, presence: true, length: { in: 2..40, message: "Le nom doit faire entre 2 et 40 caractères (longueur actuelle: %{count})" }
  validates :description, presence: true, length: { in: 20..500, message: "La description doit faire entre 20 et 500 caractères (longueur actuelle: %{count})"}
  belongs_to :category
  belongs_to :shop
  has_many :cart_items
  has_many :carts, through: :cart_items
  # has_many :orders_items
  # has_many :orders, through: :orders_items

  has_many_attached :pictures

  def decrement_available_quantity(quantity = 1)
    self.available_quantity -= quantity
    self.save
  end

  def increment_available_quantity(quantity = 1)
    self.available_quantity += quantity
    self.save
  end


end
