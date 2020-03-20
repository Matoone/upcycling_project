class MakersController < ApplicationController

  def maker_permitted_params
    params.permit(:first_name, :last_name)
  end

  def new_maker_email
    # UserMailer.become_maker_email(maker_permitted_params).deliver_now 
    puts maker_permitted_params
    flash[:success] = "Votre email a bien été envoyé."
    redirect_to new_maker_path
  end
end
