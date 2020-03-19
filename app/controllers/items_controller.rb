class ItemsController < ApplicationController
  def index
  end

  def show
    @item = item
    @item = Item.find_by(id: params[:id])
  end
end
