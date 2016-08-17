class ChargesController < ApplicationController
    layout 'application'
    before_action :require_user, only: [:new, :create]
    before_action :set_user, only: [:new]

    def new
      @@user = @user
    end

    def create
      # Amount in cents
      @amount = 100000

      customer = Stripe::Customer.create(
        :email => params[:stripeEmail],
        :source  => params[:stripeToken]
      )

      #user = User.find_by(email: :email)

      charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => @amount,
        :description => 'Thindustrial Registration Payment',
        :currency    => 'usd'
      )

      if charge
        #@payment = Payment.new()
        flash[:success] = "Payment was successfully made for " + @@user.firstname + @@user.lastname
        redirect_to user_path(@@user)
      end

    rescue Stripe::CardError => e
      flash[:error] = e.message
    end


    private

    def set_user 
      @user = User.find(params[:user_id])
    end


end
