class CategoriesController < ApplicationController
before_action :require_user

	def index
		@categories = Category.all
	end

	def new
		if !current_user.admin
	      flash[:danger] = "Only admins can create categories"
	      redirect_to categories_path
	    else
			@category = Category.new
		end
	end

	def create
		#if !current_user.admin
	      #flash[:danger] = "Only admins can add categories"
	      #redirect_to categories_path
	    #else
			@category = Category.new(category_params)
			if @category.save
				flash[:success] = "Category was created successfully"
				redirect_to categories_path
			else
				render 'new'
			end
		#end
	end

	def show

	end

	

	private

		def category_params
			params.require(:category).permit(:name)
		end

	

end