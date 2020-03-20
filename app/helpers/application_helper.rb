module ApplicationHelper
  def returnAllCategories
     Category.all
  end

  def flash_class(level)
    case level
        when 'notice'
          "alert alert-primary"
        when 'success'
          "alert alert-success"
        when 'error'
          "alert alert-danger"
        when 'alert'
          "alert alert-danger"
        else
          "alert alert-info"
    end
  end

  def is_item_quantity_sufficient_to_add_another_to_cart(item_id)
    if !user_signed_in?
      return nil
    end
    cart_item = current_user.customer.cart.cart_items.find_by(item_id: item_id)
    if cart_item
      if cart_item.cart_quantity < cart_item.item.available_quantity
        return true
      else
        return false
      end
    else
      item = Item.find_by(id: item_id)
      if item.available_quantity > 0
        return true
      else
        return false
      end
    end
  end

end
