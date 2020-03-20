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

  def cart_sections
    sections = {}
    self.cart_items.each do |cart_item|
      if sections["#{cart_item.item.shop.id}"]
        sections["#{cart_item.item.shop.id}"].push(cart_item)
      else
       sections["#{cart_item.item.shop.id}"] = []
       sections["#{cart_item.item.shop.id}"].push(cart_item)
      end
    end
    return sections
  end

  def return_section_total_price(shop_id)
    price = 0
    cart_sections["#{shop_id}"].each do |cart_item|
      price += cart_item.return_total_price
    end
    return price
  end

  def remove_all_items_from_section(shop_id)
    self.cart_sections["#{shop_id}"].each do |cart_item|
      self.cart_items.find_by(id: cart_item.id).destroy
    end
  end
  
  # def order_cart_section(shop_id)
  #   if self.cart_sections["#{shop_id}"]
  #     order = Order.create
  #     self.cart_sections["#{shop_id}"].each do |cart_item|
  #       ordered_quantity = cart_item.cart_quantity
  #       OrderItem.create(order_id: self.id, item_id: cart_item.item.id, buying_price: cart_item.item.price, order_quantity: ordered_quantity)
  #       item_to_decrement = Item.find_by(id: cart_item.item.id)
  #       item_to_decrement.decrement_available_quantity(ordered_quantity)
  #     end
  #   end
    
  # end

end
