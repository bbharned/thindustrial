class PagesController < ApplicationController
    before_action :require_user, only: [:payments]
    before_action :require_admin, only: [:payments]
	
	def index 

	end


	def schedule

	end



	def sponsors

	end



	def contact

	end


    def payments
        @payments = Payment.all
        @users = User.all
    end



    private

    def require_admin
    if logged_in? && !current_user.admin?
      flash[:danger] = "Only Admins can perform that action"
      redirect_to user_path(current_user)
    end
  end

end