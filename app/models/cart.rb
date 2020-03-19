class Cart < ApplicationRecord
  
  has_many :cart_items
  has_many :items, through: :cart_items
  belongs_to :customer, optional: true # optional true to then be able to have guest cart

 
  def add_item(item_id)
    item_in_cart = self.item_in_cart(item_id)
    if item_in_cart
      item_in_cart.cart_quantity += 1
      item_in_cart.save
      puts item_in_cart.cart_quantity
    else
      item = Item.find_by(id: item_id)
      self.items.push(item)
    end
  end

  def remove_item(item_id)
    item_in_cart = self.item_in_cart(item_id)
    if item_in_cart
      if item_in_cart.cart_quantity > 1
        item_in_cart.cart_quantity -= 1
        item_in_cart.save
      elsif item_in_cart.cart_quantity == 1
        self.items.delete(item_id)
      end
    end
  end

  def item_in_cart(item_id)
    self.cart_items.find_by(item_id: item_id)
  end

end
