class ItemsController < ApplicationController
  def index
  end

  def show
    @item = Item.find_by(id: params[:id])
  end
end
