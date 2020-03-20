class OrdersController < ApplicationController
  def new
    @cart = Cart.find(params[:cart_id])
    @section_id = params[:section_id]
    @items_total_price = @cart.return_section_total_price(@section_id)
    @items = @cart.cart_sections["#{@section_id}"]
    @shop = Shop.find_by(id: @section_id)
  end
  
  def create
    # Amount in cents
    total_price = return_section_total_price(shop_id)
    @amount = (@items_total_price * 100).to_i
  
    customer = Stripe::Customer.create({
      email: current_user.email,
      source: params[:stripeToken],
    })
  
    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: 'produits',
      currency: 'eur',
    })
  
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_order_path
  end
  
end