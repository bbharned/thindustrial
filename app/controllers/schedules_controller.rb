class SchedulesController < ApplicationController
	#before_action :require_user, only: [:index, :create, :edit, :update, :show]
	#@courses = Course.all

	def index
		if logged_in? && !current_user.admin?
	      flash[:danger] = "Only admins can view others schedules"
	      redirect_to user_path(current_user)
	    elsif logged_in? && current_user.admin?
	      @courses = Course.all
	      @schedules = Schedule.all
	  	else
	  		redirect_to root_path
	    end
	end

	def new
		@schedule = Schedule.new
	end

	def create	
	  @course = Course.find(params[:course_id])
	  @schedule = Schedule.new(user_id: current_user.id, course_id: @course.id, timeblock: @course.timeblock)

        if @schedule.save
          flash[:success] = "The selected course has been added to your schedule"
  		  redirect_to user_path(current_user)
        else
          flash[:danger] = "There was a problem adding this class"
  		  redirect_to user_path(current_user)
        end
	end

	def show
		
	end

	private
		
		# Never trust parameters from the scary internet, only allow the white list through.
	    
end