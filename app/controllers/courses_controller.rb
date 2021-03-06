class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]
  before_action :require_admin, only: [:new, :create, :update, :edit, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    @search = Course.search(params[:q])
    @courses = @search.result
  end

  def import
    Course.import(params[:file])
    redirect_to courses_path, notice: "Courses Imported"
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @chapters = @course.chapters

    @course_time = 0
    @course.chapters.each do |chapter|
      chapter.lessons.each do |lesson|
        if lesson.minutes == nil
          @course_time = @course_time + 0
        else
          @course_time = @course_time + lesson.minutes
        end
      end
    end

    if Courseuser.where(course_id: @course.id).where(user_id: current_user.id).blank? && current_user.training_subscribed?
      @courseuser = Courseuser.new
       @courseuser.user_id = current_user.id
       @courseuser.course_id = @course.id
       @courseuser.save

      @course.chapters.each do |chapter|
        @chapteruser = Chapteruser.new
        @chapteruser.user_id = current_user.id
        @chapteruser.course_id = @course.id
        @chapteruser.chapter_id = chapter.id
        @chapteruser.save

        chapter.lessons.each do |lesson|
          @lessonuser = Lessonuser.new
          @lessonuser.user_id = current_user.id
          @lessonuser.course_id = @course.id
          @lessonuser.chapter_id = chapter.id
          @lessonuser.lesson_id = lesson.id
          @lessonuser.save
        end
      end
    end  



  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course Was Successfully Updated.' }
        format.json { render :show, status: :created, location: @chapter }
      else
        format.html { render :new }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
   end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :minutes, :description)
    end
end
