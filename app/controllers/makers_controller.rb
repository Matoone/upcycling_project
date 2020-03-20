class MakersController < ApplicationController

  def new
    @maker = Maker.new(maker_permitted_params)
    
  end

  def maker_permitted_params
    params.permit(:first_name, :last_name)
  end

  def maker_send
    UserMailer.become_maker_email(self).deliver_now
  end

end
