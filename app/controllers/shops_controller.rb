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
      puts ('#'*60)
    end
  end
end
