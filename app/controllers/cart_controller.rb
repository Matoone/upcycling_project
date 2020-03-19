class CartsController < ApplicationController
  
  def create
    @user = current_user
    user_cart = Cart.create(customer: @user.customer)
  end
end
