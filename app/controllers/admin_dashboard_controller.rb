class AdminDashboardController < ApplicationController
	before_action :require_admin
	def index
		@users = User.all.order(subscribed: :desc).order(:created_at)
	end
end
