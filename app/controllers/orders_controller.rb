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
    @amount = 500
  
    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })
  
    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: 'Rails Stripe customer',
      currency: 'usd',
    })
  
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to orders_path
  end
end