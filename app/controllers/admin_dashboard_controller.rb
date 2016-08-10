class AdminDashboardController < ApplicationController
	before_action :require_admin
	def index
		@users = User.all.order(subscribed: :desc).order(:created_at)
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
		redirect_to admin_dashboard_index_path
	end

	def unsubscribe
		@user = User.find_by_id(params[:id])
		@user.subscribed = false
		@user.save
		redirect_to admin_dashboard_index_path
	end

	def make_admin
		@user = User.find_by_id(params[:id])
		@user.admin = true
		@user.save
		redirect_to admin_dashboard_index_path
	end

	def remove_admin
		@user = User.find_by_id(params[:id])
		@user.admin = false
		@user.save
		redirect_to admin_dashboard_index_path
	end


	def show_user
		@user = User.find_by_id(params[:id])
	end
end
