class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  def total_price
    self.buying_price * self.order_quantity 
  end
  
end
