class ShopsController < ApplicationController
  include ShopsHelper
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action only: [:edit, :update, :destroy] do
    maker = Shop.find_by(id: params[:id]).maker
    if !current_user.maker || !current_user.maker.is_own_identity(maker.id)
      flash[:alert] = "Vous n'êtes pas autorisé à accéder à la page d'administration de ce shop"
      redirect_to root_path
    end
  end
  # will have to check for new and create when implemented

  def show
    @shop = Shop.find_by(id: params[:id])
  end

  def edit
    @shop = Shop.find_by(id: params[:id])
  end

  def delete
    respond_to do |format|
      format.html { }
      format.js { }
    end
  end
  
  def index
    @shops = Shop.all
  end

  def create
    maker = current_user.maker
    name = params[:name]
    if maker
      @shop = Shop.new(maker: maker, name: name)
      if @shop.save
        flash[:success] = "Votre magasin a bien été créé! Vous pouvez accéder à son espace via le menu de la navbar."
        redirect_to root_path
      else
        redirect_to new_shop_path, :flash => { :error => @shop.errors.full_messages.join(', ')}
      end
    else
      flash[:danger] = "La référence de cet artisan n'existe pas."
      redirect_to root_path
    end
    
  end

  def new
    
    maker = current_user.maker
    if maker
     return true
    else
      flash[:error] = "La référence de cet artisan n'existe pas"
      redirect_to root_path
    end
  end
end
