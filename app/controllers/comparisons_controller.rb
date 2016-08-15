class ComparisonsController < ApplicationController
	before_action :load_prospect, :load_statement
  before_action :load_comparison, only: [:show, :edit, :update]
	before_action :authenticate_user!
  before_action :require_subscribed

  def index 
  	@test = Comparison.where(statement_id: @statement.id).first
    if @test != nil
      @comparisons = Comparison.where(statement_id: @statement.id).order(total_program_savings: :desc)
    else    
      load_qualified_programs(@statement)
      if @programs.first == nil
        redirect_to programs_path, notice: 'Please Add at Least 1 Processor / Program'
      else
      @comparisons = []
      @programs.each do |program|
        @comparison = Comparison.new
        set_comparison_references(@comparison, @statement, program)    
        set_vmd_per_item_fees(    @comparison, @statement, program.min_per_item_fee)
        set_vmd_mark_up(          @comparison, @statement, program.min_bp_mark_up) 
        set_vmd_access_fees(      @comparison, @statement, program)
        set_amex_fees(            @comparison, @statement, program)
        set_debit_fees(           @comparison, @statement, program)
        set_other_fees(           @comparison, @statement, program)      
        set_total_fees(           @comparison, @statement, program)     
        set_vmd_costs(            @comparison, @statement, program)
        set_amex_costs(           @comparison, @statement, program)
        set_debit_costs(          @comparison, @statement, program)
        set_other_costs(          @comparison, @statement, program)
        set_total_costs(          @comparison, @statement, program)
        set_compensation(         @comparison, program)
        set_conditional_savings(  @comparison, @statement)
        set_fixed_values(         @comparison)
        @comparison.save
        @comparisons << @comparison
      end
      @comparisons = @comparisons.order(total_program_savings: :desc)
    end
    end
  end
  
 def decrease_savings
    @comparisons = Comparison.where(statement_id: @statement.id).order(total_program_savings: :desc)
    @comparisons.each do |comparison|
      if comparison.total_program_savings > 0
        @program = Program.find_by_id(comparison.program_id)
        set_per_item_change(comparison, @statement)
        set_vmd_per_item_fees(comparison, @statement, (comparison.per_item_fee += @per_item_change) )
        set_bp_change(comparison, @statement, @per_item_change)
        set_vmd_mark_up(comparison, @statement, (comparison.bp_mark_up += @basis_points))
        set_total_fees(comparison, @statement, @program)
        set_total_savings(comparison, @statement)

        if comparison.total_program_savings < 5
          @change = comparison.total_program_savings
          @basis_points = ( @change / @statement.vmd_vol ) * 10000 
          set_vmd_mark_up(comparison, @statement, (comparison.bp_mark_up += @basis_points))
          comparison.total_program_fees += ( @statement.vmd_vol * (@basis_points.to_f / 10000) )
          set_total_savings(comparison, @statement)     
        end  
        set_compensation(comparison, @program)
        comparison.save
      end
    end
    render 'index'
  end

  

  def increase_savings
    @comparisons = Comparison.where(statement_id: @statement.id).order(total_program_savings: :desc)
    @comparisons.each do |comparison|
      if comparison.total_program_savings < comparison.savings_fixed
        @program = Program.find_by_id(comparison.program_id)
        
        set_per_item_change(comparison, @statement)
        @per_item = comparison.per_item_fee - @per_item_change
        set_vmd_per_item_fees(comparison, @statement, @per_item )
        set_bp_change(comparison, @statement, @per_item_change)
        
        @total_basis_points = comparison.bp_mark_up - @basis_points 
        set_vmd_mark_up(comparison, @statement, @total_basis_points)
        set_total_fees(comparison, @statement, @program)
        set_total_savings(comparison, @statement)
        
        @diff = comparison.savings_fixed - comparison.total_program_savings 
        if @diff < 10
        set_vmd_per_item_fees(    comparison, @statement, @program.min_per_item_fee)
        set_vmd_mark_up(          comparison, @statement, @program.min_bp_mark_up) 
        set_vmd_access_fees(      comparison, @statement, @program)
        set_amex_fees(            comparison, @statement, @program)
        set_debit_fees(           comparison, @statement, @program)
        set_other_fees(           comparison, @statement, @program)      
        set_total_fees(           comparison, @statement, @program)     
        set_vmd_costs(            comparison, @statement, @program)
        set_amex_costs(           comparison, @statement, @program)
        set_debit_costs(          comparison, @statement, @program)
        set_other_costs(          comparison, @statement, @program)
        set_total_costs(          comparison, @statement, @program)
        set_compensation(         comparison, @program)
        set_conditional_savings(  comparison, @statement)
        set_fixed_values(         comparison)
                  
        end  
        set_compensation(comparison, @program)
        comparison.save
      end
    end
    render 'index'
  end

  def show
    @program = Program.find_by_id(@comparison.program_id)
    respond_to do |format| 
      format.html
      format.pdf do
        pdf = Prawn::Document.new
        pdf.text "Hello World"
        send_data pdf.render, filename: "#{@prospect.business_name} Proposal.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @comparison.update(comparison_params)
        format.html { redirect_to prospect_statement_comparison_path(@prospect, @statement, @comparison), notice: 'Pricing was successfully updated.' }
        format.json { render :show, status: :ok, location: @comparison }
      else
        format.html { render :edit }
        format.json { render json: @comparison.errors, status: :unprocessable_entity }
      end
    end
  end

private
  def comparison_params
      params.require(:comparison).permit(:id, :bp_mark_up, :per_item_fee, :amex_bp_mark_up, :amex_per_item_fee, :pin_debit_bp_mark_up, :debit_trans_fees,
      :monthly_fees, :per_batch_fee, :monthly_pci_fees, :annual_pci_fees, :application_fee, :annual_fee, :monthly_debit_fee, :next_day_funding_fee )
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

  def load_qualified_programs(s)
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
      @vol = s.vmd_vol
      if @min < @vol && @max > @vol
      @programs << @program
      end
    end
  end

  def set_comparison_references(c, s, p)
    c.statement_id = s.id
    c.program_id = p.id
  end
  
  def set_vmd_per_item_fees(c, s, per_item_fee)
    c.per_item_fee = per_item_fee
    
    c.vs_trans_fees = ( 
      s.vs_transactions * 
      per_item_fee )
    
    c.mc_trans_fees = ( 
      s.mc_transactions * 
      per_item_fee )

    c.ds_trans_fees = ( 
      s.ds_transactions * 
      per_item_fee )
    
    c.total_vmd_trans_fees = ( 
      c.vs_trans_fees + 
      c.mc_trans_fees + 
      c.mc_trans_fees )
  end

  def set_vmd_mark_up(c, s, bp_mark_up)
    c.bp_mark_up = bp_mark_up
    
    c.vs_mark_up_fees = ( 
      s.vs_volume * 
      (bp_mark_up / 10000 ) )
    
    c.mc_mark_up_fees = ( 
      s.mc_volume * 
      (bp_mark_up / 10000 ) )
    
    c.ds_mark_up_fees = ( 
      s.ds_volume * 
      (bp_mark_up / 10000 ) )

    c.total_vmd_mark_up_fees = (
      c.vs_mark_up_fees + 
      c.mc_mark_up_fees + 
      c.ds_mark_up_fees )
  end

  def set_vmd_access_fees(c, s, p)
    c.vs_access_per_item_fees = ( 
      p.visa_access_per_item * 
      s.vs_transactions )
    
    c.mc_access_per_item_fees = ( 
      p.mc_access_per_item * 
      s.mc_transactions )

    c.ds_access_per_item_fees = ( 
      p.disc_access_per_item * 
      s.ds_transactions )

    c.vs_access_percentage_fees = (
      ( p.visa_access_percentage / 10000 ) * 
      s.vs_volume )
    
    c.mc_access_percentage_fees = (
      ( p.mc_access_percentage / 10000 ) * 
      s.mc_volume )

    c.ds_access_percentage_fees = (
      ( p.disc_access_percentage / 10000 ) * 
      s.ds_volume )

    c.total_vs_access_fees = ( 
      c.vs_access_per_item_fees + 
      c.vs_access_percentage_fees )
   
    c.total_mc_access_fees = (
      c.mc_access_per_item_fees + 
      c.mc_access_percentage_fees )
    
    c.total_ds_access_fees = ( 
      c.ds_access_per_item_fees + 
      c.ds_access_percentage_fees )
    
    c.total_vmd_access_fees = (
      c.total_vs_access_fees + 
      c.total_mc_access_fees + 
      c.total_ds_access_fees )
  end

  def set_amex_fees(c, s, p)
    c.amex_mark_up_fees = ( 
      s.amex_vol * 
      ( p.min_amex_bp_fee / 10000 ) )

    c.amex_trans_fees = ( 
      s.amex_trans * 
      p.min_amex_per_item_fee )
  end

  def set_debit_fees(c, s, p)
    c.debit_trans_fees = (
    s.debit_trans * 
    p.min_pin_debit_per_item_fee )
    
    if s.debit_trans > 0
      c.total_debit_fees = (
      c.debit_trans_fees + 
      p.min_monthly_debit_fee )
    else
      c.total_debit_fees = 0
    end
  end

  def set_other_fees(c, s, p)
      c.batch_fees = ( 
        s.batches * 
        p.min_per_batch_fee )
      c.monthly_pci_fees = p.monthly_pci_fee
      c.annual_pci_fees = p.annual_pci_fee
      c.annual_fee = 0
  end

   def set_total_fees(c, s, p)
    c.total_program_fees = (
    p.min_monthly_fees + 
    c.monthly_pci_fees + 
    ( c.annual_pci_fees / 12 ) + 
    ( c.annual_fee / 12 ) + 
    s.interchange + 
    c.total_vmd_mark_up_fees + 
    c.batch_fees + 
    c.amex_mark_up_fees + 
    c.total_vmd_trans_fees + 
    c.amex_trans_fees + 
    c.total_vmd_access_fees + 
    c.total_debit_fees )
  end

  def set_vmd_costs(c, s, p)
    c.bin_fee_costs = (
      s.vmd_vol * 
      (p.bin_sponsorship / 10000) )
    
    c.vs_trans_fee_costs = (
      s.vs_transactions * 
      p.per_item_cost )
    
    c.mc_trans_fee_costs = (
      s.mc_transactions * 
      p.per_item_cost )
    
    c.ds_trans_fee_costs = ( 
      s.ds_transactions * 
      p.per_item_cost )
    
    c.total_vmd_trans_fee_costs = (
      c.ds_trans_fee_costs + 
      c.mc_trans_fee_costs + 
      c.vs_trans_fee_costs )
  end

  def set_amex_costs(c, s, p)
    c.amex_per_item_costs = (
      s.amex_trans * 
      p.amex_per_item_cost )
    
    c.amex_mark_up_costs = (
      s.amex_vol * 
      (p.amex_bp_cost / 10000) )
  end

  def set_debit_costs(c, s, p)
    c.debit_per_item_costs = (
      s.debit_trans * 
      p.pin_debit_per_item_cost )
      
      if s.debit_trans > 0        
        c.total_debit_costs = (
        c.debit_per_item_costs + 
        p.monthly_debit_fee_cost )      
      else
        c.total_debit_costs = 0        
      end
  end

  def set_other_costs(c, s, p)
    c.batch_fee_costs = (
      s.batches * 
      p.per_batch_cost )
  end

  def set_total_costs(c, s, p)
    c.total_program_costs = (
      c.batch_fee_costs + 
      c.bin_fee_costs + 
      c.total_vmd_trans_fee_costs + 
      c.amex_per_item_costs + 
      c.amex_mark_up_costs + 
      c.total_debit_costs + 
      s.interchange + 
      p.monthly_fee_costs + 
      p.monthly_pci_cost + 
      ( p.annual_pci_cost / 12 ) )
  end

  def set_compensation(c, p)
    c.total_program_residuals = (
    ( c.total_program_fees - 
      c.total_program_costs ) * 
    ( p.residual_split / 100 ) )
    
    c.total_program_bonus = p.up_front_bonus
  end

  def set_fixed_values(c)
    c.gross_margin_fixed = (
      c.total_program_savings + 
      ( c.total_program_fees - 
        c.total_program_costs ) )
    
    c.savings_fixed = c.total_program_savings
  end

  def set_conditional_savings(c, s)
     if s.total_fees > 0
          set_total_savings(c, s)
        else
          c.total_program_savings = 0
        end 
  end
  
  def set_total_savings(c, s)
      c.total_program_savings = (
        s.total_fees - 
        c.total_program_fees )

      if c.total_program_savings < 0 && c.total_program_savings > -0.01
        c.total_program_savings = 0
      end
  end

  def set_per_item_change(c, s)
    @change = (c.savings_fixed * 0.2 )
    @per_item_change = ( ( @change * 0.5 ) / s.vmd_trans )

    if @per_item_change > 0.02
        @per_item_change = 0.02
    end
  end  

  def set_bp_change(c, s, per_item_change)
    @change = (c.savings_fixed * 0.2 )
    @bp_change = (
      @change - 
      ( per_item_change * 
        @statement.vmd_trans ) )

    @basis_points = ( 
      ( @bp_change / 
        s.vmd_vol ) * 10000 )
  end

end
