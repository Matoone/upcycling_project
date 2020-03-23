class ItemsController < ApplicationController
  def index
  end

  def new
    @shop_id = params[:shop_id]
    @shop = Shop.find_by(id: @shop_id)
    @item = Item.new(shop: @shop)
  end

  def create
    puts "#" * 200
    puts params
    item_params = params.require(:item).permit(:name, :picture, :description, :available_quantity, :price, :shop_id)
    shop = Shop.find_by(id: item_params[:shop_id].to_i)
    item = Item.new(name: item_params[:name], description: item_params[:description], available_quantity: item_params[:available_quantity].to_i, price: item_params[:price].to_f, shop: shop, category_id: params[:category_id])
    puts "-" * 30
    p item.picture.attach(params[:picture])
    puts "-" * 30
    if item.save
      puts "#" * 200
      puts "Succeeeeeeeeeeeeeeeeeddddddddddddddddddd"
      flash[:success] = "Votre object a bien été créé"
      redirect_to edit_shop_path(shop.id)
    else
      flash[:alert] = "Vote objet n'a pas pu être créé. Veuillez vérifiez les champs."
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    @item = Item.find_by(id: params[:id])
    @shop = Item.find_by(id: params[:id])
  end

  def edit
    @item = Item.find_by(id: params[:id])
  end

  def update
    @item = Item.find_by(id: params[:id])
    operation = params[:operation]

    case operation
    when "add"
      @item.increment_available_quantity
      redirect_back(fallback_location: root_path)
    when "remove"
      @item.decrement_available_quantity
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "Cette action n'existe pas"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @item = Item.find_by(id: params[:id])
    @item.is_archived = true
    @item.save
    flash[:success] = "Votre objet a bien été archivé."
    redirect_back(fallback_location: root_path)
  end
end
