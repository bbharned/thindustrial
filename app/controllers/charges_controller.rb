class ChargesController < ApplicationController
    layout 'application'

    def new

    end

    def create
      # Amount in cents
      @amount = 100000

      customer = Stripe::Customer.create(
        :email => params[:stripeEmail],
        :source  => params[:stripeToken]
      )

      charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => @amount,
        :description => 'Rails Stripe customer',
        :currency    => 'usd'
      )

      redirect_to user_path(current_user)

    rescue Stripe::CardError => e
      flash[:error] = e.message
    end


end
