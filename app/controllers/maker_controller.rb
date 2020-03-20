class MakerController < ApplicationController
  
  def create
    @maker = Maker.new(maker_permitted_params)
    if current_user.maker.mail
      flash[:success] = "Votre demande a bien été envoyé"
      redirect_to edit_user_registration_path
    else
      flash[:error] = "Not working"
      render '/users/edit'
    end
  end

  def maker_permitted_params
    params.permit(:first_name, :last_name)
  end

  def maker_send
    UserMailer.become_maker_email(self).deliver_now
  end

end
