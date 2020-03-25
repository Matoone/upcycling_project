class AddressesController < ApplicationController
  def create
    @address = Address.new(address_permitted_params)
    current_user.customer.address = @address
    if current_user.customer.save
      flash[:success] = "Votre adresse a bien été créée."
      redirect_to edit_user_registration_path
    else
      flash[:error] = "Not working"
      render '/users/edit'
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
      flash[:error] = "Not working"
      render '/users/edit'
    end
  end

  private

  def address_permitted_params
    params.permit(:first_name, :last_name, :street_number, :address_line_1, :address_line_2, :zip_code, :city)
  end
end
