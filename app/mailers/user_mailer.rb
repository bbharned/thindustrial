class UserMailer < ApplicationMailer
    default from: 'info@thinmanager.com'
 
  def welcome_email(user)
    @user = user
    @url  = 'https://thinmanager.com/login'
    delivery_options = { address: 'smtp.gmail.com',
                         port: 587,
                         user_name: 'bharned@thinmanager.com',
                         password: password,
                         authentication: 'plain',
                         enable_starttls_auto: true
                          }
    mail(to: @user.email, subject: 'Welcome to Thindustrial', delivery_method_options: delivery_options)
  end

  
  private
      def password
        password = "Corv3tt3"
      end
end
