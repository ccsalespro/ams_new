class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy, :complete]
  before_action :load_chapter
  before_action :load_course
  before_action :require_training_subscribed, only: [:show]
  before_action :require_admin, only: [:new, :create, :update, :edit, :destroy, :index]


  # GET /lessons
  # GET /lessons.json
  def index
    @lessons = Lesson.all
  end

  # GET /lessons/1
  # GET /lessons/1.json
  def show
    respond_to do |format|
      format.js
      format.html
    end

  end

  # GET /lessons/new
  def new
    @lesson = Lesson.new
    @lesson = @chapter.lessons.new
  end

  # GET /lessons/1/edit
  def edit
  end

  # POST /lessons
  # POST /lessons.json
  def create
    @lesson = @chapter.lessons.new(lesson_params)

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to course_chapter_path(@course, @chapter), notice: 'Lesson was successfully created.' }
        format.json { render :show, status: :created, location: @lesson }
      else
        format.html { render :new }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end

    @subscribed_users = User.where(training_subscribed: true)
    @subscribed_users.each do |user|
      @course.chapters.each do |chapter|
        


        @chapteruser = Chapteruser.new
        @chapteruser.user_id = user.id
        @chapteruser.course_id = @course.id
        @chapteruser.chapter_id = chapter.id
        @chapteruser.save
      end
    end

  end

  # PATCH/PUT /lessons/1
  # PATCH/PUT /lessons/1.json
  def update
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to course_chapter_lesson_path(@course, @chapter, @lesson), notice: 'Lesson was successfully updated.' }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    @lesson.destroy
    respond_to do |format|
      format.html { redirect_to course_chapter_path(@course, @chapter), notice: 'Lesson was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def complete
    @lesson.update_attribute(:completed_at, Time.now)
    redirect_to course_chapter_lesson_path(@course, @chapter, @lesson)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    def load_chapter
       @chapter = Chapter.find(params[:chapter_id])
    end

    def load_course
       @course = Course.find(params[:course_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lesson_params
      params.require(:lesson).permit(:title, :video, :minutes, :description, :chapter_id, :course_id)
    end
end
