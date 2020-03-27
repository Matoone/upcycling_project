class StaticPagesController < ApplicationController
  def index
    @address = Geocoder.coordinates(params[:search])
    @makers = Maker.all
  end
end
