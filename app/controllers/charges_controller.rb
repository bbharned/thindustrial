class ChargesController < ApplicationController
    layout 'application'
    before_action :require_user, only: [:new, :create]
    before_action :set_user, only: [:new]

    def new
      @@user = @user
    end

    def create
      # Amount in cents
      @amount = @@user.balance*100

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

      if charge["paid"] == true
        @pay_dollars = @amount/100
        @payment = Payment.new(user_id: @@user.id, email: customer.email, token: charge.id, amount: @pay_dollars)
        
        if @payment.save
          @@user.balance = @@user.balance - @pay_dollars
          if @@user.save  
            flash[:success] = "Payment was successfully made for " + @@user.firstname + " " + @@user.lastname
            redirect_to user_path(@@user)
          end
        end
      end

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charges_path
    end


    private

    def set_user 
      @user = User.find(params[:user_id])
    end


end
