class OrdersController < ApplicationController
  def new
    @cart = Cart.find(params[:cart_id])
    @section_id = params[:section_id]
    @items_total_price = @cart.return_section_total_price(@section_id)
    @items = @cart.cart_sections["#{@section_id}"]
    @shop = Shop.find_by(id: @section_id)
  end
end