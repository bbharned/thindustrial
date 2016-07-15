class CategoriesController < ApplicationController
before_action :require_user
before_action :require_admin, except: [:index, :show]


	def index
		@categories = Category.all
	end

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(category_params)
		if @category.save
			flash[:success] = "Category was created successfully"
			redirect_to categories_path
		else
			render 'new'
		end
	end

	def show
		@category = Category.find(params[:id])
		@category_courses = @category.courses.all
	end

	

	private

		def category_params
			params.require(:category).permit(:name)
		end

		def require_admin
			if logged_in? and !current_user.admin? 
				flash[:danger] = "Only admins can perform that action"
	      		redirect_to categories_path
	      	end
		end

		def require_user
			if !logged_in?
				flash[:danger] = "You must be logged in to perform that action"
	      		redirect_to login_path
	      	end
		end

end