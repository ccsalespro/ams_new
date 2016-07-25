class ComparisonsController < ApplicationController
	before_action :load_prospect, :load_statement
	before_action :authenticate_user!
  	before_action :require_subscribed
  def index 
  	@programusers = Programuser.all.where(user_id: current_user.id)
  	@programs = []
    @programusers.each do |programuser|
      @program = Program.find_by_id(programuser.program_id)
      @programs << @program
    end	
    @programs
  end
  def show
  	@program = Program.find(params[:program_id])
  end

private
	def load_prospect
		@prospect = Prospect.find(params[:prospect_id])
	end
	def load_statement
		@statement = @prospect.statements.find(params[:statement_id])
	end
end
