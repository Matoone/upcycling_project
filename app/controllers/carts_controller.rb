class CartsController < ApplicationController
  
  def create
    @user = current_user
    user_cart = Cart.create(customer: @user.customer)
  end

  def show
    @cart = Cart.find_by(id: params[:id])
  end
end
