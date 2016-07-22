class ComparisonsController < ApplicationController
	before_action :load_prospect, :load_statement, :load_programs
	before_action :authenticate_user!
  	before_action :require_subscribed
  def index  			
  end
  def show
  end

private
	def load_prospect
		@prospect = Prospect.find(params[:prospect_id])
	end
	def load_statement
		@statement = @prospect.statements.find(params[:statement_id])
	end
	def load_programs
		@programs = Program.all
	end
end
