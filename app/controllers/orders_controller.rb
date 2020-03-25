class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
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
    registered_customer_id = current_user.customer.stripe_customer_id
    if registered_customer_id
      customer_id = registered_customer_id
    else
      customer = Stripe::Customer.create({
        email: current_user.email,
        source: params[:stripeToken],
      })
      current_user.customer.stripe_customer_id = customer.id
      current_user.customer.save
      customer_id = customer.id
    end
    
    begin
      charge = Stripe::Charge.create({
        customer: customer_id,
        amount: @amount,
        description: 'produits',
        currency: 'eur',
      })
    
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_order_path
    end

    order = Order.create(stripe_customer_id: customer_id, customer_id: current_user.customer.id, shop_id: shop_id)
    order.add_items_to_order( current_user.customer.cart, shop_id)
    current_user.customer.cart.remove_all_items_from_section(shop_id)
    
    flash[:success] = "Votre paiement a fonctionné. Vous recevrez un email de confirmation dans les prochaines minutes. Merci pour votre commande!"
    redirect_to root_path
  end

  def update
    order = Order.find_by(id: params[:id])
    case params[:operation]
    when "shipped"
      order.is_shipped = true
      order.ship_date = DateTime.now
      order.save
      flash[:success] = "Le statut de la commande est bien passé en envoyé"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "L'opération demandée n'existe pas"
      redirect_back(fallback_location: root_path)
    end
  end
end
