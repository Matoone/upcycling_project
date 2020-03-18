class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @id = params[:id]
  end
end
