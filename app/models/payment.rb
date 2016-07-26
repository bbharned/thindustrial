class Payment < ActiveRecord::Base
    belongs_to :user
    attr_accessor :name, :card_number, :card_cvv, :card_expires_month, :card_expires_year
    
    require 'rubygems'
    require 'yaml'
    require 'authorizenet' 

    require 'securerandom'

    include AuthorizeNet::API

    
    def self.month_options
        Date::MONTHNAMES.compact.each_with_index.map { |name, i| ["#{i+1} - #{name}", i+1]}
    end
    
    def self.year_options
        (Date.today.year..(Date.today.year+10)).to_a
    end

    def authorize_payment
      transaction = Transaction.new('API_LOGIN', 'API_KEY', :gateway => :sandbox)

      request = CreateTransactionRequest.new

      request.transactionRequest = TransactionRequestType.new()
      request.transactionRequest.amount = 16.00
      request.transactionRequest.payment = PaymentType.new
      request.transactionRequest.payment.creditCard = CreditCardType.new('4242424242424242','0220','123') 
      request.transactionRequest.transactionType = TransactionTypeEnum::AuthCaptureTransaction

      response = transaction.create_transaction(request)

      if response.messages.resultCode == MessageTypeEnum::Ok
        flash[:success] = "Successful charge (auth + capture) (authorization code: #{response.transactionResponse.authCode})"
        #puts "Successful charge (auth + capture) (authorization code: #{response.transactionResponse.authCode})"

      else
        puts response.messages.messages[0].text
        puts response.transactionResponse.errors.errors[0].errorCode
        puts response.transactionResponse.errors.errors[0].errorText
        raise "Failed to charge card."
      end
    end
    

end
