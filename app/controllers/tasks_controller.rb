class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy] 
  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @prospect = Prospect.find(params[:prospect_id])
    @task = @prospect.tasks.new(task_params)
    @task.user = current_user

    respond_to do |format|
      if @task.save
        format.html { redirect_to :back, notice: 'Task Added' }
        format.js { render :layout => false }
      else
        format.html { render action: "new" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Task was successfully destroyed.' }
      format.js { render :layout => false }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:prospect_id, :body, :finish_date, :user_id)
    end
end
