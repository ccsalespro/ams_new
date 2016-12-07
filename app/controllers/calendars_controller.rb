class CalendarsController < ApplicationController
  before_action :authenticate_user!
  def index
    @prospects = current_user.prospects
    @tasks = current_user.tasks
    @grouped_tasks = @tasks.group_by(&:finish_date)
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @completed_tasks = @tasks.select { |task| task.completed? == true }
    @uncompleted_tasks = @tasks.select { |task| task.completed? == false }
    @next_task =  @uncompleted_tasks.first
  end

end
