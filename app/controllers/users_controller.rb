class UsersController < ApplicationController
	before_action :require_admin
def index
		@users = User.all.order(subscribed: :desc).order(:created_at)
		@search = @users.search(params[:q])
    @users = @search.result

    @allusers = User.all
		@subscribed_users = User.where(subscribed: true)
		@admins = User.where(admin: true)
		@course_subscribers = User.where(training_subscribed: true)
		@prospects = Prospect.all
		@notes = Note.all
		@tasks = Task.all
		@completed_tasks, @uncompleted_tasks = @tasks.partition { |task| task.completed_at != nil }

		@statements = Statement.all
	end

end