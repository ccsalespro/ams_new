class CalendarsController < ApplicationController
  def index
    @prospects = Prospect.all
    @tasks = Task.all
    @grouped_tasks = @tasks.group_by(&:finish_date)
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @sorted_tasks = @tasks.sort_by{ |t| t.finish_date }
    @completed_tasks = @sorted_tasks.select { |task| task.completed? == true }
    @uncompleted_tasks = @sorted_tasks.select { |task| task.completed? == false }
  end

end
