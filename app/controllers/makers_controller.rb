class MakersController < ApplicationController

  def new
    @maker = Maker.new(maker_permitted_params)

  end

  def email
    @maker = current_user.id
    puts "-" *30
    puts "Yeah"
    puts "-" *30
  end

  def maker_permitted_params
    params.permit(:first_name, :last_name)
  end

  def new_maker_email
    #UserMailer.become_maker_email(maker_permitted_params).deliver_now
    puts "-" *30
    puts maker_permitted_params
    puts "-" *30
  end

end
