class AdminDashboardController < ApplicationController
	before_action :require_admin
	def index
		@users = User.all.order(subscribed: :desc).order(:created_at)
		@subscribed_users = User.where(subscribed: true)
		@admins = User.where(admin: true)
		@course_subscribers = User.where(training_subscribed: true)
		@prospects = Prospect.all
		@notes = Note.all
		@tasks = Task.all
		@completed_tasks, @uncompleted_tasks = @tasks.partition { |task| task.completed_at != nil }

		@statements = Statement.all
	end

	def destroy_user
		@user = User.find_by_id(params[:id])
		@user.destroy
		redirect_to admin_dashboard_index_path
	end

	def subscribe
		@user = User.find_by_id(params[:id])
		@user.subscribed = true
		@user.save
		redirect_to :controller => 'admin_dashboard', :action => 'show_user', :id => @user.id
	end

	def unsubscribe
		@user = User.find_by_id(params[:id])
		@user.subscribed = false
		@user.save
		redirect_to :controller => 'admin_dashboard', :action => 'show_user', :id => @user.id
	end

	def make_admin
		@user = User.find_by_id(params[:id])
		@user.admin = true
		@user.save
		redirect_to :controller => 'admin_dashboard', :action => 'show_user', :id => @user.id
	end

	def remove_admin
		@user = User.find_by_id(params[:id])
		@user.admin = false
		@user.save
		redirect_to :controller => 'admin_dashboard', :action => 'show_user', :id => @user.id
	end


	def show_user
		@user = User.find_by_id(params[:id])
	end
end
