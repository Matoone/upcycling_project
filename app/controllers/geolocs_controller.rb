class GeolocsController < ApplicationController
  def index
    @makers = Maker.all
    addresses = []
    @makers.each do |maker|
      if maker.address && maker.is_validated && maker.shop
        maker_data = { :id => maker.id, :shop_name => maker.shop.name, :latitude => maker.address.latitude, :longitude => maker.address.longitude, :maker_description => maker.description, :shop_id => maker.shop.id }
        puts "["*80
        p maker_data[:shop_path]
        addresses.push(maker_data)
      end
    end
    respond_to do |format|
      format.json do
        render json: addresses.to_json
        
      end
    end
    
  end
end
