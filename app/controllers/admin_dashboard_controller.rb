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
    date = @user.last_sign_in_at
    date = date.to_s[0,10]
    date = date.split("-")
    timeyear = date[0]
    timemonth = date[1]
    timeday = date[2]
    @user_last_sign_in = "#{timemonth}/#{timeday}/#{timeyear}"

    @user_programusers = Programuser.where(user_id: @user.id)
    @user_programs = Program.where(personal: true)
    @user_pro = []
    	@user_programusers.each do |programuser|
    		@user_programs.each do |program|
    			if program.id == programuser.program_id
    				@user_pro << program
    			end
    		end
    	end

    	@user_statements = []
			@user.prospects.each do |p|
				p.statements.each do |statement|
					@user_statements << statement
				end
			end

			@user_prospects = Prospect.where(user_id: @user.id)

	end

	 def destroy_prospect
	 	@prospect = Prospect.find_by_id(params[:id])
    @prospect.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Prospect was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end
