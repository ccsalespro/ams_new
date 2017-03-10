class UsersController < ApplicationController
	before_action :require_admin
def index
		@users = User.all.order(:created_at)
		@search = @users.search(params[:q])
    @users = @search.result

    @allusers = User.all
		@admins = User.where(admin: true)
		@prospects = Prospect.all
		@notes = Note.all
		@tasks = Task.all
		@completed_tasks, @uncompleted_tasks = @tasks.partition { |task| task.completed_at != nil }
		@statements = Statement.all
	end

end