class MakersController < ApplicationController
  def new
    @user = current_user
  end

  def create
    operation = params[:operation]

    case operation

    when "create"
      maker = Maker.new(user: current_user, description: maker_permitted_params[:description], email_pro: maker_permitted_params[:email_pro], website: maker_permitted_params[:website])
      maker_address = Address.new(first_name: maker_permitted_params[:first_name], last_name: maker_permitted_params[:last_name], address_line_1: maker_permitted_params[:address_line_1], zip_code: maker_permitted_params[:zip_code], city: maker_permitted_params[:city], maker: maker)

      if maker_address.save && maker.save 
        UserMailer.become_maker_email_admin(maker_permitted_params).deliver_now
        UserMailer.become_maker_email_confirmation(maker_permitted_params).deliver_now
        flash[:success] = "Votre email a bien été envoyé. Un mail de confirmation vous a été envoyé."
        redirect_to edit_user_registration_path
      else
        redirect_to new_maker_path, :flash => { :error => maker.errors.full_messages.join(', ') + '   ' +  maker_address.errors.full_messages.join(', ')}
      end

    when "validate"
      @maker = Maker.find_by(id: params[:maker_id])
      @maker.is_validated = true
      if @maker.save
        flash[:success] = "Le compte a bien été validé."
        # brancher le mailer pour envoyer un mail d'acceptation
        redirect_to root_path
      else
        redirect_to root_path, :flash => { :error => @maker.errors.full_messages.join(', ') }
      end
    
    when "deny"
      @maker = Maker.find_by(id: params[:maker_id])
      @maker.destroy
      # Brancher le mailer pour envoyer un mail de refus
      flash[:success] = "Le compte a bien été refusé."
      redirect_to root_path
      
    else
      flash[:error] = "Cette oprération n'existe pas."
      redirect_to root_path
    end
  end

  def validate_maker
    @maker = User.find_by(id: params[:maker_id]).maker
  end

  private

  def maker_permitted_params
    params.permit(:user_id, :first_name, :last_name, :address_line_1, :address_line_2, :zip_code, :city, :website, :description, :email_pro)
  end

end

