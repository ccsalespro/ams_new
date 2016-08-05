class CourseusersController < ApplicationController
  before_action :require_admin, only: [:index, :update, :edit]
  before_action :set_courseuser, only: [:edit, :update]

def index
    @courseusers = Courseuser.all
  end

  def update
    respond_to do |format|
      if @courseuser.update(courseuser_params)
        format.html { redirect_to courseusers_path, notice: 'Quiz score was successfully updated.' }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit }
        format.json { render json: @courseuser.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  private

  def set_courseuser
    @courseuser = Courseuser.find(params[:id])
  end

  def courseuser_params
      params.require(:courseuser).permit(:quiz_score)
    end

end
