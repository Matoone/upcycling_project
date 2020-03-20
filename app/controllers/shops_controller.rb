class ShopsController < ApplicationController
  def show
    @shop = Shop.find_by(id: params[:id])
   
  end

  def edit
    @shop = Shop.find_by(id: params[:id])
  end
end
