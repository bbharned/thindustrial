class UsersController < ApplicationController

before_action :set_user, only: [:edit, :update, :show, :charge]
before_action :require_user, only: [:index, :edit, :update, :show, :charge]
before_action :require_same_user, only: [:edit, :update, :destroy, :charge]
before_action :require_admin, only: [:destroy]

def index 
  @users = User.paginate(page: params[:page], per_page: 10)
end

def new
   @user = User.new
end
  
def create
	@user = User.new(user_params)
	
	if @user.save
      session[:user_id] = @user.id
      UserMailer.welcome_email(@user).deliver_later
  		flash[:success] = "Welcome to Thindustrial #{@user.firstname}"
  		redirect_to user_path(@user)
	else
  		render 'new'
	end

end


def edit
    #@user = User.find(params[:id])
end
  

  
def update
    #@user = User.find(params[:id])
    if @user.update(user_params)
    	flash[:success] = "Your Account Was Sucessfully Updated"
    	redirect_to user_path
    else
    	render 'edit'
    end
end



def show
  #@schedules = Schedule.find(params[:id])
  #@schedules = Schedule.all
end


def charge 
  if logged_in? && current_user == @user || current_user.admin == true
    @user = User.find(params[:id])

  #if form_for(:payment).submit
    #@authorize_payment = PaymentsController.payment(payment_params)
    #if @authorize_payment.response.messages.resultCode == MessageTypeEnum::Ok
      #@payment = Payment.new(user_id: @user.id, email: @user.email, token: "")
      #if @payment.save
        #flash[:success] = "Payment Saved Successfully"
        #redirect_to users_path
      #else
        #flash[:danger] = "There was a problem saving your payment"
        #redirect_to users_path
      #end
    #else 
      #flash[:danger] = "There was a problem charging the card"
      #render charge
    #end
  #end
  else 
    flash[:danger] = "Only Admins can perform that action"
    redirect_to root_path
  end
end


def destroy
  @user = User.find(params[:id])
  @schedulesout = Schedule.where(user_id: @user.id)
  @schedulesout.destroy_all
  if @schedulesout.destroy_all
    @user.destroy
  end
  flash[:danger] = "User and courses scheduled for user have been removed."
  redirect_to users_path
end


def make_payment
  @user = User.find(params[:id])
  @authorize_payment = authorize_payment
  if AuthorizeNet::API::MessageTypeEnum::Ok
    #flash[:success] = "Payment Saved Successfully"
    redirect_to user_path(@user)
  end
end

  
private 
  def user_params
    params.require(:user).permit(:firstname, :lastname, :company, :street, :city, :state, :zipcode, :phone, :email, :password)
  end

  def payment_params
    params.require(:payment).permit(:card_number, :card_cvv, :card_expires_month, :card_expires_year)
  end

  def set_user 
    @user = User.find(params[:id])
  end

  def register

  end

  def authorize_payment
      require 'rubygems'
      require 'yaml'
      require 'authorizenet'

      config = YAML.load_file(File.dirname(__FILE__) + "/credentials.yml")

      transaction = AuthorizeNet::API::Transaction.new(config['api_login_id'], config['api_transaction_key'], :gateway => :sandbox)

      request = AuthorizeNet::API::CreateTransactionRequest.new

      request.transactionRequest = AuthorizeNet::API::TransactionRequestType.new()
      request.transactionRequest.amount = 16.00
      request.transactionRequest.payment = AuthorizeNet::API::PaymentType.new
      request.transactionRequest.payment.creditCard = AuthorizeNet::API::CreditCardType.new('4242424242424242', '0220', '123') 
      request.transactionRequest.transactionType = AuthorizeNet::API::TransactionTypeEnum::AuthCaptureTransaction

      response = transaction.create_transaction(request)

      if response.messages.resultCode == AuthorizeNet::API::MessageTypeEnum::Ok
        flash[:success] = "Successful charge (auth + capture) (authorization code: #{response.transactionResponse.authCode})"
      else
        flash[:danger] = response.messages.messages[0].text
      end  
  end

  def require_same_user
    if current_user != @user and !current_user.admin?
      flash[:danger] = "You Can Only Edit Your Own Account"
      redirect_to user_path(current_user)
    end
  end

  def require_admin
    if logged_in? && !current_user.admin?
      flash[:danger] = "Only Admins can perform that action"
      redirect_to users_path
    end
  end

  


end