class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  after_create do
    create_customer
    welcome_send
  end
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :customer
  has_one :maker

  private
  def create_customer
    user_customer = Customer.create!(user: self)
    puts "Customer created id #{user_customer.id}"
  end

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

end
