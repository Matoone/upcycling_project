class UserMailer < ApplicationMailer
  default from: 'solunacisv@gmail.com'

  def welcome_email(user)
    @user = user
    @url  = "http://localhost:3000/users/sign_in"

    mail(to: @user.email, subject: 'Bienvenue chez nous !')
  end

  def become_maker_email_admin(params)
    @infos_user = params
    @url_create = "http://localhost:3000/makers"
    mail(to: "solunacisv@gmail.com", subject: 'Nvlle demande de créateur')
  end

  def become_maker_email_confirmation(params)
    @infos_user = params
    mail(to: "solunacisv@gmail.com", subject: 'Votre demande pour devenir créateur')
  end

end
