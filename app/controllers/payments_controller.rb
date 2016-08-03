class PaymentsController < ApplicationController

    
    def authorize_payment
          
          require 'rubygems'
          require 'authorizenet'
          require 'securerandom'

          AuthorizeNet::API

          @user = User.find(params[:id])
          @ccname = params[:name]
          @card_number = params[:card_number]
          @card_cvv = params[:card_cvv]
          @card_expires_month = params[:card_expires_month]
          @card_expires_year = params[:card_expires_year]

          
          config = YAML.load_file(File.dirname(__FILE__) + "/credentials.yml")

          transaction = AuthorizeNet::API::Transaction.new(config['api_login_id'], config['api_transaction_key'], :gateway => :sandbox)

          request = AuthorizeNet::API::CreateTransactionRequest.new

          request.transactionRequest = AuthorizeNet::API::TransactionRequestType.new()
          request.transactionRequest.amount = ((SecureRandom.random_number + 1 ) * 150 ).round(2)
          request.transactionRequest.payment = AuthorizeNet::API::PaymentType.new
          request.transactionRequest.payment.creditCard = AuthorizeNet::API::CreditCardType.new('4242424242424242', '02/2020', '123') 
          request.transactionRequest.transactionType = AuthorizeNet::API::TransactionTypeEnum::AuthCaptureTransaction

          response = transaction.create_transaction(request)

          if response.messages.resultCode == AuthorizeNet::API::MessageTypeEnum::Ok
            flash[:success] = "Successful charge (authorization code: #{response.transactionResponse.authCode})"
            redirect_to user_path(@user)
          else
            flash[:danger] = "That Did Not Work - Please try again later"
            redirect_to user_path(@user)
          end 

          return response 
    end


end