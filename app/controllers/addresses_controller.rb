class AddressesController < ApplicationController
  def create
    permitted_params = address_permitted_params
    @address = Address.new(first_name: permitted_params[:first_name], last_name: permitted_params[:last_name], address_line_1: permitted_params[:address_line_1], address_line_2: permitted_params[:address_line_2], zip_code: permitted_params[:zip_code], city: permitted_params[:city], customer: current_user.customer)
    if @address.save
      flash[:success] = "Votre adresse a bien été créée."
      redirect_to edit_user_registration_path
    else
      redirect_to edit_user_registration_path, :flash => { :error => @address.errors.full_messages.join(', ')}
    end
  end

  def update
    @address = current_user.customer.address
    @address.assign_attributes(address_permitted_params)
    puts "-" * 30
    p @address
    puts "-" * 30
    if @address.save
      flash[:success] = "Votre adresse a bien été mise à jour."
      redirect_to edit_user_registration_path
    else
      redirect_to edit_user_registration_path, :flash => { :error => @address.errors.full_messages.join(', ')}
    end
  end

  def index
    @addresses = Address.all

    respond_to do |format|
      format.html
      format.json do
        geojson = @addresses.map do |address|
          {
            type: 'Feature',
            geometry: {
              type: 'Point',
              coordinates: [address.longitude, address.latitude],
            },
            properties: {
              name: address.maker.first_name,
              popupContent: render_to_string(partial: 'addresses/address.html', locals: { address: address } ),
              address: address.address_line_1
            }
          }
        end

        render json: geojson
      end
    end
  end

  private

  def address_permitted_params
    params.permit(:first_name, :last_name,:address_line_1, :address_line_2, :zip_code, :city)
  end
end
