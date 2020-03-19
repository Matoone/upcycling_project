class CartItem < ApplicationRecord
  validates :cart_quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0}
  belongs_to :cart
  belongs_to :item

  def return_total_price
    self.item.price * self.cart_quantity
  end
end
