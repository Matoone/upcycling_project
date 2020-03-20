class AddressesController < ApplicationController
  def create
    @address = Address.new(address_permitted_params)
    current_user.customer.address = @address
    if current_user.customer.save
      puts "-" * 30
      puts "yeah"
      p @address
      puts "-" * 30
      redirect_to '/users/edit'
    else
      puts "-" * 30
      puts "nop"
      puts "-" * 30
      render '/users/edit'
    end
  end

  def update
    @address = current_user.customer.address
    @address = address_permitted_params
    if current_user.customer.save
      puts "-" * 30
      puts "yeah"
      p @address
      puts "-" * 30
    else
      puts "-" * 30
      puts "nop"
      puts "-" * 30
    end
  end

  def address_permitted_params
    params.permit(:first_name, :last_name, :street_number, :address_line_1, :address_line_2, :zip_code, :city)
  end
end
