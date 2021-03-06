class ChaptersController < ApplicationController
  before_action :set_chapter, only: [:show, :edit, :update, :destroy]
  before_action :load_course, except: [:index, :import]
  before_action :require_admin, only: [:new, :create, :update, :edit, :destroy, :index]
  
  # GET /chapters
  # GET /chapters.json
  def index
    @chapters = Chapter.all
  end

  def import
    Chapter.import(params[:file])
    redirect_to chapters_path, notice: "Chapters Imported"
  end

  # GET /chapters/1
  # GET /chapters/1.json
  def show
    @lessons = @chapter.lessons
    @chapter_time = 0
    @lessons.each do |lesson|
     if lesson.minutes == nil
      @chapter_time = @chapter_time + 0
     else
       @chapter_time = @chapter_time + lesson.minutes
     end
    end
  end

  # GET /chapters/new
  def new
    @chapter = @course.chapters.new
  end

  # GET /chapters/1/edit
  def edit
  end

  # POST /chapters
  # POST /chapters.json
  def create
    @chapter = @course.chapters.new(chapter_params)

    respond_to do |format|
      if @chapter.save
        format.html { redirect_to @course, notice: 'Chapter was successfully created.' }
        format.json { render :show, status: :created, location: @chapter }
      else
        format.html { render :new }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /chapters/1
  # PATCH/PUT /chapters/1.json
  def update
    respond_to do |format|
      if @chapter.update(chapter_params)
        format.html { redirect_to course_chapter_path(@course, @chapter), notice: 'Chapter was successfully updated.' }
        format.json { render :show, status: :ok, location: @chapter }
      else
        format.html { render :edit }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chapters/1
  # DELETE /chapters/1.json
  def destroy
    @chapter.destroy
    respond_to do |format|
      format.html { redirect_to @course, notice: 'Chapter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chapter
      @chapter = Chapter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chapter_params
      params.require(:chapter).permit(:name, :minutes, :course_id)
    end

    def load_course
      @course = Course.find(params[:course_id])
    end
end
