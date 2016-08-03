class ComparisonsController < ApplicationController
	before_action :load_prospect, :load_statement, :load_programs
  before_action :load_comparison, only: [:show]
	before_action :authenticate_user!
  before_action :require_subscribed

  def index 
  	@programusers = Programuser.where(user_id: current_user.id)
  	@programs = []
  	@programusers.each do |programuser|
  		@program = Program.find_by_id(programuser.program_id)
      @min = @program.min_volume
        if @program.max_volume > 0
          @max = @program.max_volume
        else
          @max = 10000000
        end
      @vol = @statement.vmd_vol
        if @min < @vol && @max > @vol
    		@programs << @program
        end
  	end
    @comparisons = []
    @programs.each do |program|
      @comparison = Comparison.new
      @comparison.statement_id = @statement.id
      @comparison.program_id = program.id
      @comparison.batch_fees = @statement.batches * program.min_per_batch_fee
      @comparison.vs_mark_up_fees = ( @statement.vs_volume * (program.min_bp_mark_up / 10000 ) )
      @comparison.mc_mark_up_fees = ( @statement.mc_volume * (program.min_bp_mark_up / 10000 ) )
      @comparison.ds_mark_up_fees = ( @statement.ds_volume * (program.min_bp_mark_up / 10000 ) )
      @comparison.total_vmd_mark_up_fees = @comparison.vs_mark_up_fees + @comparison.mc_mark_up_fees + @comparison.ds_mark_up_fees
      @comparison.amex_mark_up_fees = ( @statement.amex_vol * ( program.min_amex_bp_fee / 10000 ) )
      @comparison.vs_trans_fees = ( @statement.vs_transactions * program.min_per_item_fee )
      @comparison.mc_trans_fees = ( @statement.mc_transactions * program.min_per_item_fee )
      @comparison.ds_trans_fees = ( @statement.ds_transactions * program.min_per_item_fee )
      @comparison.total_vmd_trans_fees = @comparison.vs_trans_fees + @comparison.mc_trans_fees + @comparison.mc_trans_fees
      @comparison.amex_trans_fees = ( @statement.amex_trans * program.min_amex_per_item_fee )
      @comparison.vs_access_per_item_fees = ( program.visa_access_per_item * @statement.vs_transactions )
      @comparison.mc_access_per_item_fees = ( program.mc_access_per_item * @statement.mc_transactions )
      @comparison.ds_access_per_item_fees = ( program.disc_access_per_item * @statement.ds_transactions )
      @comparison.vs_access_percentage_fees = (( program.visa_access_percentage / 10000 ) * @statement.vs_volume )
      @comparison.mc_access_percentage_fees = (( program.mc_access_percentage / 10000 ) * @statement.mc_volume )
      @comparison.ds_access_percentage_fees = (( program.disc_access_percentage / 10000 ) * @statement.ds_volume )
      @comparison.total_vs_access_fees = @comparison.vs_access_per_item_fees + @comparison.vs_access_percentage_fees
      @comparison.total_mc_access_fees = @comparison.mc_access_per_item_fees + @comparison.mc_access_percentage_fees
      @comparison.total_ds_access_fees = @comparison.ds_access_per_item_fees + @comparison.ds_access_percentage_fees
      @comparison.total_vmd_access_fees = @comparison.total_vs_access_fees + @comparison.total_mc_access_fees + @comparison.total_ds_access_fees
      @comparison.monthly_pci_fees = program.monthly_pci_fee
      @comparison.annual_pci_fees = program.annual_pci_fee
      @comparison.annual_fee = 0
      @comparison.debit_trans_fees = @statement.debit_trans * program.min_pin_debit_per_item_fee
      
      if @statement.debit_trans > 0
        @comparison.total_debit_fees = @comparison.debit_trans_fees + program.min_monthly_debit_fee
      else
        @comparison.total_debit_fees = 0
      end
      
      @comparison.total_program_fees = program.min_monthly_fees + @comparison.monthly_pci_fees + ( @comparison.annual_pci_fees / 12 ) + ( @comparison.annual_fee / 12 ) + @statement.interchange + @comparison.total_vmd_mark_up_fees + @comparison.batch_fees + @comparison.amex_mark_up_fees + @comparison.total_vmd_trans_fees + @comparison.amex_trans_fees + @comparison.total_vmd_access_fees + @comparison.total_debit_fees
      
      @comparison.batch_fee_costs = @statement.batches * program.per_batch_cost
      @comparison.bin_fee_costs = @statement.vmd_vol * (program.bin_sponsorship / 10000)
      @comparison.vs_trans_fee_costs = @statement.vs_transactions * program.per_item_cost
      @comparison.mc_trans_fee_costs = @statement.mc_transactions * program.per_item_cost
      @comparison.ds_trans_fee_costs = @statement.ds_transactions * program.per_item_cost
      @comparison.total_vmd_trans_fee_costs = @comparison.ds_trans_fee_costs + @comparison.mc_trans_fee_costs + @comparison.vs_trans_fee_costs
      @comparison.amex_per_item_costs = @statement.amex_trans * program.amex_per_item_cost
      @comparison.amex_mark_up_costs = @statement.amex_vol * (program.amex_bp_cost / 10000)
      @comparison.debit_per_item_costs = @statement.debit_trans * program.pin_debit_per_item_cost
      
      if @statement.debit_trans > 0
        @comparison.total_debit_costs = @comparison.debit_per_item_costs + program.monthly_debit_fee_cost
      else
        @comparison.total_debit_costs = 0
      end

      @comparison.total_program_costs = @comparison.batch_fee_costs + @comparison.bin_fee_costs + @comparison.total_vmd_trans_fee_costs + @comparison.amex_per_item_costs + @comparison.amex_mark_up_costs + @comparison.total_debit_costs + @statement.interchange + program.monthly_fee_costs + program.monthly_pci_cost + ( program.annual_pci_cost / 12 )
      @comparison.total_program_residuals = ( @comparison.total_program_fees - @comparison.total_program_costs ) * ( program.residual_split / 100 )
      @comparison.total_program_bonus = program.up_front_bonus

      if @statement.total_fees > 0
        @comparison.total_program_savings = @statement.total_fees - @comparison.total_program_fees
      else
        @comparison.total_program_savings = 0
      end
      
      @comparison.save
      @comparisons << @comparison
    end
  end
  
  def calculate_up
    @comparisons = Comparison.where(statement_id: @statement.id)
  end

  def show
    @program = Program.find_by_id(@comparison.program_id)
  end

private
  def comparison_params
      params.require(:comparison).permit(:id)
  end

  def load_comparison
    @comparison = Comparison.find(params[:id])
  end

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
