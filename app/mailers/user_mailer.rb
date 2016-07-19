class UserMailer < ApplicationMailer
    default from: 'bharned@thinmanager.com'
 
  def welcome_email(user)
    @user = user
    @url  = 'http://localhost:3000/login'
    delivery_options = { user_name: 'bharned@thinmanager.com',
                         password: 'Corv3tt3',
                         address: 'smtp.gmail.com',
                         port: 587 }
    mail(to: @user.email, subject: 'Welcome to Thindustrial', delivery_method_options: delivery_options)
  end
end
