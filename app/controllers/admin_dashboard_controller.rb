class AdminDashboardController < ApplicationController
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

	def destroy_user
	  @user = User.find_by_id(params[:id])
      redirect_to users_path, notice: "subscription cancelled"
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

	 def destroy_programuser_admin_panel
	 	@user = User.find_by_id(params[:user_id])
    @programuser = Programuser.where(user_id: @user.id).where(program_id: params[:program_id]).first
    @programuser.destroy
    redirect_to :back, notice: 'Program Was Successfully Deleted From User'
  end

  def assign_programs
  	@user = User.find_by_id(params[:user_id])
  	@program = Program.find_by_id(params[:program_id])
  	@program_processor = Processor.find_by_id(@program.processor_id)
  	@users = User.all
  end


	def show_user
		@user = User.find_by_id(params[:id])
    	date = @user.created_at
		date = date.to_s[0,10]
		date = date.split("-")
		timeyear = date[0]
		timemonth = date[1]
		timeday = date[2]
		@user_created_at = "#{timemonth}/#{timeday}/#{timeyear}"

	    @user_programusers = Programuser.where(user_id: @user.id)
	    @user_pro = []
    	@user_programusers.each do |programuser|
			@program = Program.find_by_id(programuser.program_id)
			@user_pro << @program
    	end

    	@user_statements = []
			@user.prospects.each do |p|
				p.statements.each do |statement|
					@user_statements << statement
				end
			end

			@user_prospects = Prospect.where(user_id: @user.id)
	end

	def all_tickets
		@tickets = Ticket.all
		@important_tickets, @unimportant_tickets = @tickets.partition { |ticket| ticket.important == true }
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
