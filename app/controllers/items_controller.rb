class ItemsController < ApplicationController
  def index
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
