class UsersController < ApplicationController

before_action :set_user, only: [:edit, :update, :show]
before_action :require_user, only: [:index, :edit, :update, :show]
before_action :require_same_user, only: [:edit, :update, :destroy]
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

def destroy
  @user = User.find(params[:id])
  @user.destroy
  flash[:danger] = "User and courses scheduled for user have been removed."
  redirect_to users_path
end

  
private 
  def user_params
    params.require(:user).permit(:firstname, :lastname, :company, :street, :city, :state, :zipcode, :phone, :email, :password)
  end

  def set_user 
    @user = User.find(params[:id])
  end

  def register

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