class MakersController < ApplicationController
  def new
    @user = current_user
  end

  def create
    #UserMailer.become_maker_email_admin(maker_permitted_params).deliver_now
    #UserMailer.become_maker_email_confirmation(maker_permitted_params).deliver_now

    puts "-" * 30
    puts maker_permitted_params
    puts "-" * 30
    flash[:success] = "Votre email a bien été envoyé. Un mail de confirmation vous a été envoyé."
    redirect_to new_maker_path
  end

  def new_maker_email
    puts "-" * 30
    puts "Yeah"
    puts "-" * 30
    UserMailer.become_maker_email_admin(maker_permitted_params).deliver_now
  end

  private

  def maker_permitted_params
    params.permit(:maker_id, :first_name, :last_name, :address_line_1, :address_line_2, :street_number, :zip_code, :city, :website, :description)
  end

end
