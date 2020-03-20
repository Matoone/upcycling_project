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
    total_price = params[:total_price]
    @amount = (total_price.to_f * 100).to_i
    puts '#' *120
    puts @amount
    shop_id = params[:shop_id]
  
    customer = Stripe::Customer.create({
      email: current_user.email,
      source: params[:stripeToken],
    })
    begin
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
    order = Order.create(stripe_customer_id: customer.id, customer_id: current_user.customer.id, shop_id: shop_id)
    order.add_items_to_order( current_user.customer.cart, shop_id)
    current_user.customer.cart.remove_all_items_from_section(shop_id)
    
    flash[:success] = "Votre paiement a fonctionné. Vous recevrez un email de confirmation dans les prochaines minutes. Merci pour votre commande!"
    redirect_to root_path
  end
end