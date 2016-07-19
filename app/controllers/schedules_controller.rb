class SchedulesController < ApplicationController
	#before_action :require_user, only: [:index, :create, :edit, :update, :show]
	before_action :set_schedule, only: [:show, :destroy]
	#before_action :require_unique_time, only: [:create]

	def index
		if logged_in? && !current_user.admin?
	      flash[:danger] = "Only admins can view all schedules"
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
	  @schedules = Schedule.all
	  @course = Course.find(params[:course_id])
	  @schedule = Schedule.new(user_id: current_user.id, course_id: @course.id, timeblock: @course.timeblock) 

	  if @schedules.any?{ |session| session.timeblock == @schedule.timeblock and session.user_id == @schedule.user_id }

	  	flash[:danger] = "You already have a session at that time."
		redirect_to user_path(current_user)

	  else

		  if @schedule.save 
		      flash[:success] = "The selected session has been added to your schedule"
			  redirect_to user_path(current_user)
		  else
		      flash[:danger] = "There was a problem adding this session"
			  redirect_to user_path(current_user)
		  end

	  end
	end



	def show
		
	end

	def destroy
		if !current_user and !current_user.admin
	      flash[:danger] = "You can only change your own schedule"
	      redirect_to user_path(current_user)
	    elsif current_user.admin
	    	@schedule.destroy
	      	flash[:success] = "Session was successfully removed from schedule."
	    else
	      @schedule.destroy
	      flash[:success] = "Session was successfully removed from your schedule."
			redirect_to user_path(current_user)
    	end
	end

	private
	
	def set_schedule
      @schedule = Schedule.find(params[:id])
    end	

    
		# Never trust parameters from the scary internet, only allow the white list through.
	    
end