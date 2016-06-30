class SchedulesController < ApplicationController
	before_action :require_user, only: [:index, :edit, :update, :show]
	
	def index
		if !current_user.admin
	      flash[:danger] = "Only admins can view others schedules"
	      redirect_to user_path(current_user)
	    else
	      @schedule = Schedule.all
	    end
	end

	def new

	end

	def show
		#@schedule = Schedule.find(params[:id])
	end
end