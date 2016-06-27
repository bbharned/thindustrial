class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :require_user
  #before_action :require_same_user, only: [:edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    if !current_user.admin
      flash[:danger] = "Only admins can add courses"
      redirect_to courses_path
    else
      @course = Course.new
    end
  end

  # GET /courses/1/edit
  def edit
    if !current_user.admin
      flash[:danger] = "Only admins can edit courses"
      redirect_to courses_path
    end
  end

  # POST /courses
  # POST /courses.json
  def create
    if !current_user.admin
      flash[:danger] = "Only admins can add courses"
      redirect_to courses_path
    else
      @course = Course.new(course_params)

      respond_to do |format|
        if @course.save
          format.html { redirect_to @course, notice: 'Course was successfully created.', style: 'color:green;' }
          format.json { render :show, status: :created, location: @course }
        else
          format.html { render :new }
          format.json { render json: @course.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.'}
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    if !current_user.admin
      flash[:danger] = "Only admins can add courses"
      redirect_to courses_path
    else
      @course.destroy
      respond_to do |format|
        format.html { redirect_to courses_url, notice: 'Course was successfully deleted.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:title, :description, :timeblock)
    end

    def require_same_user
      #if current_user != @course.user 
        #flash[:danger] = "you can only view your own profile"
        #redirect_to root_path
      #end
    end

end
