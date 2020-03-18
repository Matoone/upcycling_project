class ShopsController < ApplicationController
  def show
    @items = Item.all
  end
end
