class CategoriesController < ApplicationController
  def show
    @items = Item.all
    @category = Category.find_by(id: params[:id])
    @id = params[:id]
  end
end
