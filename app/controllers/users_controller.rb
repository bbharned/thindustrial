class UsersController < ApplicationController

def new
   @user = User.new
end
  
def create
	@user = User.new(user_params)
	
	if @user.save
  		flash[:success] = "Welcome to Thindustrial #{@user.firstname}"
  		redirect_to courses_path
	else
  		render 'new'
	end

end
  
 private 
 def user_params
    params.require(:user).permit(:firstname, :lastname, :company, :street, :city, :state, :zipcode, :phone, :email, :password)
 end
	
	def login

	end


	def register

	end


end