class ItemPicturesController < ApplicationController
  def create
    puts "-" * 30
    puts params
    puts "-" * 30

    render new_item_path(:shop_id => @shop.id)
  end
end
