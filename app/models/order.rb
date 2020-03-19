class Order < ApplicationRecord
  

  has_many :order_items
  has_many :items, through: :order_items
  belongs_to :shop
  belongs_to :customer

  def total
    self.order_items.map{ |order_item| order_item.total_price }.sum
  end

  private

  # def order_cart
  #   self.customer.cart.items.each do |item|
  #     ordered_quantity = self.customer.cart.cart_items.find_by(item_id: item.id).cart_quantity
  #     OrderItem.create(order_id: self.id, item_id: item.id, buying_price: item.price, order_quantity: ordered_quantity)
  #     item_to_decrement= Item.find_by(id: item.id)
  #     item_to_decrement.decrement_available_quantity(ordered_quantity)
  #   end
  #   self.customer.cart.items.destroy_all
  # end



end
