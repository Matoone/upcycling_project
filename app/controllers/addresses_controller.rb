class AddressesController < ApplicationController
  def create
    puts "-" * 30
    @permitted_params = params.permit(:first_name, :last_name, :street_number, :address_line_1, :address_line_2, :zip_code, :city)
    @address = Address.new(@permitted_params)
    puts @address.street_number
    current_user.customer.address = @address
    current_user.customer.save
    p current_user.customer.address.errors.messages
    #current_user.customer.address = @address
    #current_user.customer.address = @address
    puts "-" * 30
  end

  def update
    puts "-" * 30
    puts "yeah"
    puts params
    puts "-" * 30
  end
end
