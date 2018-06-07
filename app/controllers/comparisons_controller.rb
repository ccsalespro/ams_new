class ComparisonsController < ApplicationController
  before_action :load_prospect, :load_statement
  before_action :load_comparison, only: [:show, :edit, :update, :savings_summary, :savings_detail]
  before_action :authenticate_user!

  def index
    @test = Comparison.where(statement_id: @statement.id).first
    if @test != nil
      update_comparison_interchange
    else
      load_qualified_programs(@statement)
      if @programs.first == nil
        redirect_to programs_path, notice: 'Please Add at Least 1 Processor / Program'
      else
        @comparisons = []
        @programs.each do |program|
          @comparison = Comparison.new
          set_comparison_references(@comparison, @statement, program)
          set_all_custom_field_c_values_to_zero(@comparison)
          set_custom_fields(        @comparison, @statement, program)
          set_other_fees(           @comparison, @statement, program)
          set_vmd_per_item_fees(    @comparison, @statement, program.min_per_item_fee)
          set_vmd_mark_up(          @comparison, @statement, program.min_bp_mark_up)
          set_vmd_access_fees(      @comparison, @statement)
          set_amex_fees(            @comparison, @statement)
          set_debit_fees(           @comparison, @statement)
          set_total_fees(           @comparison, @statement)
          set_vmd_costs(            @comparison, @statement, program)
          set_amex_costs(           @comparison, @statement, program)
          set_debit_costs(          @comparison, @statement, program)
          set_other_costs(          @comparison, @statement, program)
          set_total_costs(          @comparison, @statement, program)
          set_compensation(         @comparison, program)
          set_conditional_savings(  @comparison, @statement)
          set_fixed_values(         @comparison)

          set_per_item_change(      @comparison, @statement)
          set_bp_change(            @comparison, @statement, @comparison.per_item_change)
          set_starting_fees(        @comparison)

          set_vmd_per_item_fees(    @comparison, @statement, @comparison.starting_per_item )
          set_vmd_mark_up(          @comparison, @statement, @comparison.starting_bp)
          set_total_fees(           @comparison, @statement)
          set_total_savings(        @comparison, @statement)
          set_compensation(         @comparison, program)

          @comparison.save
          create_cc_fields(         @comparison, program)

          @comparisons << @comparison
        end
        @comparisons = @comparisons.sort_by { |x| -x[:total_program_savings] }
        if Programuser.where(user_id: current_user.id).where(default_program: true).present?
          @program_user = Programuser.where(user_id: current_user.id).where(default_program: true).first
          @comparison = @comparisons.find {|c| c.program_id == @program_user.program_id}
          if @comparison != nil
            redirect_to prospect_statement_comparison_path(@prospect, @statement, @comparison)
          end
        end
      end
    end
  end

  def set_starting_fees(c)
    if c.program.pricing_structure.interchange
      c.starting_per_item = (c.per_item_fee + (c.per_item_change * 2))
      c.starting_bp = (c.bp_mark_up + (c.bp_change * 2))
      c.change_counter = 0
    else
      c.starting_per_item = c.per_item_fee
      c.starting_bp = c.bp_mark_up
      c.change_counter = 0
    end
  end

  def set_per_item_change(c, s)
    @change = (c.savings_fixed * 0.2 )
    @per_item_change = ( ( @change * 0.5 ) / s.vmd_trans )

    if @per_item_change > 0.02
        @per_item_change = 0.02
    elsif @per_item_change < 0.01
        @per_item_change = 0.01
    end

      c.per_item_change = @per_item_change

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

    if @basis_points < 5
      @basis_points = 5
    end

      c.bp_change = @basis_points

  end

  def update_comparison_interchange
      @comparisons = Comparison.where(statement_id: @statement.id)
      @comparisons.each do |comparison|
        comparison_no_nil(comparison)
        @program = Program.find_by_id(comparison.program_id)
        set_total_fees(comparison, @statement)
        set_conditional_savings(comparison, @statement)
        set_total_costs(comparison, @statement, @program)
        comparison.save
      end
      @comparisons = @comparisons.sort_by { |x| -x[:total_program_savings] }
  end

 def decrease_margin
    @comparisons = Comparison.where(statement_id: @statement.id).order(total_program_savings: :desc)
      @comparisons.each do |comparison|
        @program = Program.find_by_id(comparison.program_id)
        comparison.change_counter -= 1
        if comparison.program.pricing_structure.interchange
          if comparison.change_counter < -1
            set_vmd_per_item_fees(    comparison, @statement, @program.min_per_item_fee)
            set_vmd_mark_up(          comparison, @statement, @program.min_bp_mark_up)
          else
            @basis_points = comparison.starting_bp + (comparison.bp_change * (comparison.change_counter))
            @basis_points = @basis_points.round(-1)
            @per_item = comparison.starting_per_item + (comparison.per_item_change * (comparison.change_counter))
            set_vmd_per_item_fees(    comparison, @statement, @per_item)
            set_vmd_mark_up(          comparison, @statement, @basis_points)
          end
          set_total_fees(comparison, @statement)
          set_total_savings(comparison, @statement)
          set_compensation(comparison, @program)
        end
        comparison.save
      end
    render 'index'
  end



  def increase_margin
    @comparisons = Comparison.where(statement_id: @statement.id).order(total_program_savings: :desc)
      @comparisons.each do |comparison|
        @program = Program.find_by_id(comparison.program_id)
        comparison.change_counter += 1
        if comparison.program.pricing_structure.interchange
          @basis_points = comparison.starting_bp + (comparison.bp_change * (comparison.change_counter))
          @basis_points = @basis_points.round(-1)
          @per_item = comparison.starting_per_item + (comparison.per_item_change * (comparison.change_counter))
          set_vmd_per_item_fees(    comparison, @statement, @per_item)
          set_vmd_mark_up(          comparison, @statement, @basis_points)
          set_total_fees(comparison, @statement)
          set_total_savings(comparison, @statement)
          set_compensation(comparison, @program)
        end
        comparison.save
      end
    render 'index'
  end

  def show
    @program = Program.find_by_id(@comparison.program_id)
    @statement = Statement.find_by_id(@comparison.statement_id)

    @vs_access_fees = (@comparison.vs_access_per_item_fees) + (@comparison.vs_access_percentage_fees)
    @total_visa_fees = (@statement.vs_fees + @comparison.vs_trans_fees + @vs_access_fees + @comparison.vs_mark_up_fees)
    @mc_access_fees = (@comparison.mc_access_per_item_fees) + (@comparison.mc_access_percentage_fees)
    @total_mc_fees = (@statement.mc_fees + @comparison.mc_trans_fees + @mc_access_fees + @comparison.mc_mark_up_fees)
    @ds_access_fees = (@comparison.ds_access_per_item_fees) + (@comparison.ds_access_percentage_fees)
    @total_ds_fees = (@statement.ds_fees + @comparison.ds_trans_fees + @ds_access_fees + @comparison.ds_mark_up_fees)

    if @statement.debit_vol > 0
      @total_debit_fees = (@statement.debit_network_fees + (@statement.debit_trans * @comparison.pin_debit_per_item_fee))
    else
      @total_debit_fees = 0
    end

    if @statement.amex_vol > 0
    @amex_mark_up = ( @statement.amex_vol * (@comparison.amex_bp_mark_up.to_f / 10000 ) )
    @total_amex_fees = (@statement.amex_interchange + (@statement.amex_trans * @comparison.amex_per_item_fee) + @amex_mark_up)
    else
    @amex_mark_up = 0
    @total_amex_fees = 0
    end

    @transactions = @statement.vs_transactions + @statement.mc_transactions + @statement.ds_transactions + @statement.amex_trans + @statement.debit_trans
    @total_cost = @statement.vs_fees + @statement.mc_fees + @statement.ds_fees + @statement.debit_network_fees + @statement.amex_interchange
    @total_access_fees = @comparison.total_vs_access_fees + @comparison.total_mc_access_fees + @comparison.total_ds_access_fees
    @total_credit_card_vol = (@statement.total_vol - (@statement.debit_vol + @statement.check_card_vol + @statement.unreg_debit_vol))

    @other_fees = ( @comparison.total_program_fees - (@total_amex_fees + @total_debit_fees + @total_visa_fees + @total_mc_fees + @total_ds_fees))
    @transactions = @statement.vs_transactions + @statement.mc_transactions + @statement.ds_transactions + @statement.amex_trans + @statement.debit_trans
    @total_credit_card_vol = (@statement.total_vol - (@statement.debit_vol + @statement.check_card_vol + @statement.unreg_debit_vol))

    if @statement.vs_total_per_item_fees != nil
    #Side by Side Passthrough Variables
    @visa_credit_volume = (@statement.vs_volume * (@statement.credit_percent / 100))
    @visa_check_card_volume = (@statement.vs_volume * ((100 - @statement.credit_percent) / 100))

    @current_vs_da = (@visa_credit_volume * (@statement.c_visa_access_percentage / 10000)) +
    ((@visa_credit_volume / @statement.vs_avg_ticket) * @statement.c_visa_access_per_item) +
    (@visa_check_card_volume * (@statement.c_check_card_access_percentage / 10000)) +
    ((@visa_check_card_volume / @statement.vs_avg_ticket) * @statement.c_check_card_access_per_item)

    @current_mc_da = @statement.mc_volume * (@statement.c_mc_access_percentage / 10000) +
      @statement.mc_transactions * @statement.c_mc_access_per_item
    @current_ds_da = @statement.ds_volume * (@statement.c_disc_access_percentage / 10000) +
      @statement.ds_transactions * @statement.c_disc_access_per_item

    @total_current_access_fees = @current_vs_da + @current_mc_da + @current_ds_da

    @total_current_pass_through = @statement.current_interchange +
    @statement.c_network_access_fees +
    @statement.c_opt_blue_fees +
    @total_current_access_fees

    @total_proposed_pass_through = @statement.vmd_interchange +
    @statement.debit_network_fees +
    @statement.amex_interchange +
    @total_access_fees

    @passthrough_savings = @total_current_pass_through - @total_proposed_pass_through

    #Side by Side Processing Variables
    @total_current_processing = @statement.vs_total_per_item_fees + @statement.mc_total_per_item_fees + @statement.ds_total_per_item_fees +
      @statement.vs_total_bp_mark_up + @statement.mc_total_bp_mark_up + @statement.ds_total_bp_mark_up + @statement.amex_total_per_item_fees +
      @statement.debit_total_per_item_fees + @statement.amex_total_bp_mark_up + @statement.debit_total_bp_mark_up

    @total_proposed_processing = ( @statement.vmd_trans * @comparison.per_item_fee ) + (@statement.vmd_vol * ( @comparison.bp_mark_up.to_f / 10000) ) +
      @comparison.debit_trans_fees + @comparison.amex_trans_fees + @comparison.amex_mark_up_fees

    @processing_savings = @total_current_processing - @total_proposed_processing

    #Side by Side Other Fees Variables
    @total_current_other_fees = (@statement.c_batch_fee * @statement.batches) +
    @statement.c_monthly_fees +
    @statement.c_monthly_pci_fee +
    @statement.c_monthly_debit_fee +
    @statement.c_annual_fee

    @other_fees_savings = @total_current_other_fees - @other_fees

    #Side by Side Totals Summary
    @total_current = @statement.total_fees
    @total_proposed = @comparison.total_program_fees
    @total_savings = @comparison.total_program_savings

    #Side by Side Processing Fees
    @vs_current_processing_fees = @statement.vs_total_per_item_fees + @statement.vs_total_bp_mark_up
    @vs_proposed_processing_fees = @comparison.vs_mark_up_fees + @comparison.vs_trans_fees
    @vs_processing_savings = @vs_current_processing_fees - @vs_proposed_processing_fees

    @mc_current_processing_fees = @statement.mc_total_per_item_fees + @statement.mc_total_bp_mark_up
    @mc_proposed_processing_fees = @comparison.mc_mark_up_fees + @comparison.mc_trans_fees
    @mc_processing_savings = @mc_current_processing_fees - @mc_proposed_processing_fees

    @ds_current_processing_fees = @statement.ds_total_per_item_fees + @statement.ds_total_bp_mark_up
    @ds_proposed_processing_fees = @comparison.ds_mark_up_fees + @comparison.ds_trans_fees
    @ds_processing_savings = @ds_current_processing_fees - @ds_proposed_processing_fees

    @amex_current_processing_fees = @statement.amex_total_bp_mark_up + @statement.amex_total_per_item_fees
    @amex_proposed_processing_fees = @comparison.amex_trans_fees + @comparison.amex_mark_up_fees
    @amex_processing_savings = @amex_current_processing_fees - @amex_proposed_processing_fees

    @debit_current_processing_fees = @statement.debit_total_bp_mark_up + @statement.debit_total_per_item_fees
    @debit_proposed_processing_fees = @comparison.debit_trans_fees
    @debit_processing_savings = @debit_current_processing_fees - @debit_proposed_processing_fees

    @vs_mark_up_savings = @statement.vs_total_bp_mark_up - (@statement.vs_volume * (@comparison.bp_mark_up.to_f / 10000))
    @vs_per_item_savings = @statement.vs_total_per_item_fees - (@statement.vs_transactions * @comparison.per_item_fee)

    @mc_mark_up_savings = @statement.mc_total_bp_mark_up - (@statement.mc_volume * (@comparison.bp_mark_up.to_f / 10000))
    @mc_per_item_savings = @statement.mc_total_per_item_fees - (@statement.mc_transactions * @comparison.per_item_fee)

    @ds_mark_up_savings = @statement.ds_total_bp_mark_up - (@statement.ds_volume * (@comparison.bp_mark_up.to_f / 10000))
    @ds_per_item_savings = @statement.ds_total_per_item_fees - (@statement.ds_transactions * @comparison.per_item_fee)

    @amex_mark_up_savings = @statement.amex_total_bp_mark_up - (@statement.amex_vol * (@comparison.amex_bp_mark_up.to_f / 10000))
    @amex_per_item_savings = @statement.amex_total_per_item_fees - (@statement.amex_trans * @comparison.amex_per_item_fee)

    @type = CustomFieldType.find_by_slug_string("pin_volume_bp")
    @fields = @program.custom_fields.where(custom_field_type_id: @type.id)
    if @fields != nil
      @debit_bp_mark_up = 0
      @fields.each do |field|
      @debit_bp_mark_up += field.amount

      end
      @debit_mark_up_savings = @statement.debit_total_bp_mark_up - (@statement.debit_vol * (@debit_bp_mark_up.to_f / 10000))
    else
      @debit_mark_up_savings = @statement.debit_total_bp_mark_up - 0
    end

    @debit_per_item_savings = @statement.debit_total_per_item_fees - (@statement.debit_trans * @comparison.pin_debit_per_item_fee)
    @current_monthly_fees = @statement.c_monthly_fees + @statement.c_monthly_pci_fee + @statement.c_monthly_debit_fee + ( @statement.c_annual_fee / 12 )
    @proposed_monthly_fees = @comparison.monthly_fees + @comparison.monthly_pci_fees + @comparison.custom_monthly_fees
    @monthly_fee_savings = @current_monthly_fees - @proposed_monthly_fees

    @current_batch_fees = @statement.c_batch_fee * @statement.batches
    @proposed_batch_fees = @comparison.per_batch_fee * @statement.batches
    @batch_fee_savings = @current_batch_fees - @proposed_batch_fees
  end

    @statement.presented_program = @program.name
    @statement.save
    respond_to do |format|
      format.html
    end
  end

  def savings_summary
    respond_to do |format|
    format.pdf do
        pdf = ComparisonPdf.new(@prospect, @statement, @comparison, view_context, current_user)
        send_data pdf.render, filename: "#{@prospect.business_name} Proposal.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end

  def savings_detail
    respond_to do |format|
    format.pdf do
        pdf = DetailPdf.new(@prospect, @statement, @comparison, view_context, current_user)
        send_data pdf.render, filename: "#{@prospect.business_name} Proposal.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end

  def edit
  end

  def update
    @program = Program.find_by_id(@comparison.program_id)
    @comparison.update(comparison_params)
      comparison_no_nil(@comparison)
      pricing_wizard_no_nill(@comparison)
      set_all_custom_field_c_values_to_zero(@comparison)
      update_custom_field_values(@comparison, @statement, @program)
      set_vmd_per_item_fees(    @comparison, @statement, @comparison.per_item_fee)
      set_vmd_mark_up(          @comparison, @statement, @comparison.bp_mark_up)
      set_vmd_access_fees(      @comparison, @statement)
      set_amex_fees(            @comparison, @statement)
      set_debit_fees(           @comparison, @statement)
      set_total_fees(           @comparison, @statement)
      set_compensation(         @comparison, @program)
      set_conditional_savings(  @comparison, @statement)
      @comparison.save
      redirect_to prospect_statement_comparison_path(@prospect, @statement, @comparison), notice: 'Pricing was successfully updated.'
  end

private
  def comparison_params
      params.require(:comparison).permit(:id, :per_item_change, :notes, :bp_mark_up, :per_item_fee, :amex_bp_mark_up, :amex_per_item_fee, :pin_debit_bp_mark_up, :debit_trans_fees,
      :monthly_fees, :per_batch_fee, :monthly_pci_fees, :monthly_pci_fee, :annual_pci_fees, :application_fee, :annual_fee, :monthly_debit_fee, :next_day_funding_fee, :pin_debit_per_item_fee, cc_fields_attributes: [ :id, :name, :amount, :cost ] )
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

  def set_other_fees(c, s, p)
      c.vs_access_per_item_fee = p.visa_access_per_item
      c.vs_access_percentage_fee = p.visa_access_percentage
      c.mc_access_per_item_fee = p.mc_access_per_item
      c.mc_access_percentage_fee = p.mc_access_percentage
      c.ds_access_per_item_fee = p.disc_access_per_item
      c.ds_access_percentage_fee = p.disc_access_percentage
      c.monthly_pci_fee = p.monthly_pci_fee
      c.annual_pci_fee = p.annual_pci_fee
      c.pin_debit_per_item_fee = p.min_pin_debit_per_item_fee
      c.pin_debit_bp_mark_up = 0
      c.monthly_debit_fee = p.min_monthly_debit_fee
      c.next_day_funding_fee = p.next_day_funding_monthly_fee
      c.amex_per_item_fee = p.min_amex_per_item_fee
      c.amex_bp_mark_up = p.min_amex_bp_fee
      c.amex_per_item_cost = s.amex_per_item_cost
      c.amex_percentage_cost = s.amex_percentage_cost
      c.application_fee = p.min_application_fee
      c.per_batch_fee = p.min_per_batch_fee
      c.batch_fees = (
        s.batches *
        p.min_per_batch_fee )
      c.monthly_pci_fees = p.monthly_pci_fee
      c.annual_pci_fees = p.annual_pci_fee
      c.monthly_fees = p.min_monthly_fees
      c.annual_fee = 0
  end

  def set_vmd_per_item_fees(c, s, per_item_fee)
    c.per_item_fee = per_item_fee.round(2)

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
      c.ds_trans_fees )
  end

  def set_vmd_mark_up(c, s, bp_mark_up)
    c.bp_mark_up = bp_mark_up

    c.vs_mark_up_fees = (
      s.vs_volume *
      (c.bp_mark_up.to_f / 10000 ) )

    c.mc_mark_up_fees = (
      s.mc_volume *
      (c.bp_mark_up.to_f / 10000 ) )

    c.ds_mark_up_fees = (
      s.ds_volume *
      (c.bp_mark_up.to_f / 10000 ) )

    c.total_vmd_mark_up_fees = (
      c.vs_mark_up_fees +
      c.mc_mark_up_fees +
      c.ds_mark_up_fees )
  end

  def set_vmd_access_fees(c, s)
    c.vs_access_per_item_fees = (
      c.vs_access_per_item_fee *
      s.vs_transactions )

    c.mc_access_per_item_fees = (
      c.mc_access_per_item_fee *
      s.mc_transactions )

    c.ds_access_per_item_fees = (
      c.ds_access_per_item_fee *
      s.ds_transactions )

    c.vs_access_percentage_fees = (
      ( c.vs_access_percentage_fee.to_f / 10000 ) *
      s.vs_volume )

    c.mc_access_percentage_fees = (
      ( c.mc_access_percentage_fee.to_f / 10000 ) *
      s.mc_volume )

    c.ds_access_percentage_fees = (
      ( c.ds_access_percentage_fee.to_f / 10000 ) *
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

  def set_amex_fees(c, s)
    c.amex_mark_up_fees = (
      s.amex_vol *
      ( c.amex_bp_mark_up.to_f / 10000 ) )

    c.amex_trans_fees = (
      s.amex_trans *
      c.amex_per_item_fee )

    c.amex_total_opt_blue = (
      (c.amex_per_item_cost * s.amex_trans) +
      (s.amex_vol * (c.amex_percentage_cost / 100)))
  end

  def set_debit_fees(c, s)
    c.debit_trans_fees = (
    s.debit_trans *
    c.pin_debit_per_item_fee )

    if s.debit_trans > 0
      c.total_debit_fees = (
      c.debit_trans_fees +
      c.monthly_debit_fee)
    else
      c.total_debit_fees = 0
    end
  end

   def set_total_fees(c, s)
    if c.program.pricing_structure.interchange
      interchange = s.interchange
    else
      interchange = 0
    end
    c.batch_fees = (
        s.batches *
        c.per_batch_fee )
    c.total_program_fees = (
    c.monthly_fees +
    c.monthly_pci_fees +
    ( c.annual_pci_fees / 12 ) +
    ( c.annual_fee / 12 ) +
    interchange +
    c.total_vmd_mark_up_fees +
    c.batch_fees +
    c.amex_mark_up_fees +
    c.total_vmd_trans_fees +
    c.amex_trans_fees +
    c.total_vmd_access_fees +
    c.total_debit_fees +
    c.custom_monthly_fees +
    (c.custom_annual_fees / 12) +
    c.custom_total_vmd_per_item_fees +
    c.custom_total_vmd_volume_bp_fees +
    c.custom_total_amex_per_item_fees +
    c.custom_total_amex_volume_bp_fees +
    c.custom_total_pin_per_item_fees +
    c.custom_total_pin_volume_bp_fees)
  end

  def set_vmd_costs(c, s, p)
    c.bin_fee_costs = (
      ( s.vmd_vol * (p.bin_sponsorship.to_f / 10000) ) +
      c.custom_vmd_volume_bp_costs )

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
      c.vs_trans_fee_costs +
      c.custom_vmd_per_item_fee_costs)
  end

  def set_amex_costs(c, s, p)
    c.amex_per_item_costs = (
      (s.amex_trans * p.amex_per_item_cost ) +
      c.custom_amex_per_item_costs)
    if s.amex_trans > 0
    c.amex_mark_up_costs = (
      (s.amex_vol * (p.amex_bp_cost.to_f / 10000 ) ) +
       c.custom_amex_volume_bp_costs)
    else
      c.amex_mark_up_costs = 0
    end
  end

  def set_debit_costs(c, s, p)
    c.debit_per_item_costs = (
      (s.debit_trans * p.pin_debit_per_item_cost ) +
      c.custom_pin_per_item_costs)

      if s.debit_trans > 0
        c.total_debit_costs = (
        c.debit_per_item_costs +
        p.monthly_debit_fee_cost +
        c.custom_pin_volume_bp_costs )
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
      c.total_vmd_access_fees +
      p.monthly_fee_costs +
      p.monthly_pci_cost +
      ( p.annual_pci_cost / 12 ) +
      c.custom_monthly_fee_costs +
      (c.custom_annual_fee_costs / 12 ) )
  end

  def set_compensation(c, p)
    c.total_program_residuals = (
    ( c.total_program_fees -
      c.total_program_costs ) *
    ( p.residual_split.to_f / 100 ) )

    c.total_program_bonus =
      p.up_front_bonus +
      (c.custom_sales_bonus - c.custom_sales_bonus_costs)
    if c.application_fee > 0
      c.total_program_bonus += (c.application_fee - p.application_fee_cost)
    end
    if c.custom_one_time_fee > 0
      c.total_program_bonus += (c.custom_one_time_fee - c.custom_one_time_fee_costs)
    end
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

    def create_cc_fields(c, p)
      @custom_fields = CustomField.where(program_id: p.id)
      if @custom_fields.first != nil

         @custom_fields.each do |field|
          @custom_field_type = CustomFieldType.find_by_id(field.custom_field_type_id)

          @cc_field = CcField.new
          @cc_field.comparison_id = c.id
          @cc_field.custom_field_type_id = @custom_field_type.id
          @cc_field.name = field.name
          @cc_field.amount = field.amount
          @cc_field.cost = field.cost
          @cc_field.save
        end
      end
    end

    def update_custom_field_values(c, s, p)
      @custom_fields = CcField.where(comparison_id: c.id)
    if @custom_fields.first != nil

      @custom_fields.each do |field|
        @custom_field_type = CustomFieldType.find_by_id(field.custom_field_type_id)
        @slug_string = @custom_field_type.slug_string

        case @slug_string

        when "monthly_fee"
          c.custom_monthly_fees += field.amount
          c.custom_monthly_fee_costs += field.cost
        when "annual_fee"
          c.custom_annual_fees += field.amount
          c.custom_annual_fee_costs += field.cost
        when "vmd_per_item"
          c.custom_vmd_per_item_fee += field.amount
          c.custom_vmd_per_item_fee_cost += field.cost
        when "vmd_volume_bp"
          c.custom_vmd_volume_bp += field.amount
          c.custom_vmd_volume_bp_cost += field.cost
        when "amex_per_item"
          c.custom_amex_per_item += field.amount
          c.custom_amex_per_item_cost += field.cost
        when "amex_volume_bp"
          c.custom_amex_volume_bp += field.amount
          c.custom_amex_volume_bp_cost += field.cost
        when "pin_per_item"
          c.custom_pin_per_item += field.amount
          c.custom_pin_per_item_cost += field.cost
        when "pin_volume_bp"
          c.custom_pin_volume_bp += field.amount
          c.custom_pin_volume_bp_cost += field.cost
        when "sales_bonus"
          c.custom_sales_bonus += field.amount
          c.custom_sales_bonus_costs += field.cost
        when "one_time_fee"
          c.custom_one_time_fee += field.amount
          c.custom_one_time_fee_costs += field.cost
        when "service_fee"
          c.service_fee += field.amount
        end
      end
      if c.custom_vmd_per_item_fee > 0
        c.custom_total_vmd_per_item_fees = (s.vmd_trans * c.custom_vmd_per_item_fee)
        c.custom_vmd_per_item_fee_costs = (s.vmd_trans * c.custom_vmd_per_item_fee_cost)
      end
      if c.custom_vmd_volume_bp > 0
        c.custom_total_vmd_volume_bp_fees = (s.vmd_vol * ( c.custom_vmd_volume_bp.to_f / 10000 ) )
        c.custom_vmd_volume_bp_costs = (s.vmd_vol * ( c.custom_vmd_volume_bp_cost.to_f / 10000 ) )
      end
      if c.custom_amex_per_item > 0
        c.custom_total_amex_per_item_fees = (s.amex_trans * c.custom_amex_per_item)
        c.custom_amex_per_item_costs = (s.amex_trans * c.custom_amex_per_item_cost)
      end
      if c.custom_amex_volume_bp > 0
        c.custom_total_amex_volume_bp_fees = (s.amex_vol * ( c.custom_amex_volume_bp.to_f / 10000 ) )
        c.custom_amex_volume_bp_costs = (s.amex_vol * ( c.custom_amex_volume_bp_cost.to_f / 10000 ) )
      end
      if c.custom_pin_per_item > 0
        c.custom_total_pin_per_item_fees = (s.debit_trans * c.custom_pin_per_item)
        c.custom_pin_per_item_costs = (s.debit_trans * c.custom_pin_per_item_cost)
      end
      if c.custom_pin_volume_bp > 0
        c.custom_total_pin_volume_bp_fees = (s.debit_vol * ( c.custom_pin_volume_bp.to_f / 10000 ) )
        c.custom_pin_volume_bp_costs = (s.debit_vol * ( c.custom_pin_volume_bp_cost.to_f / 10000 ) )
      end
      if c.service_fee > 0
        c.service_fees = s.total_vol * (c.service_fee.to_f / 10000)
      end
    end
    end

    def set_custom_fields(c, s, p)
    @custom_fields = CustomField.where(program_id: p.id)
    if @custom_fields.first != nil

      @custom_fields.each do |field|
        @custom_field_type = CustomFieldType.find_by_id(field.custom_field_type_id)
        @slug_string = @custom_field_type.slug_string

        case @slug_string

        when "monthly_fee"
          c.custom_monthly_fees += field.amount
          c.custom_monthly_fee_costs += field.cost
        when "annual_fee"
          c.custom_annual_fees += field.amount
          c.custom_annual_fee_costs += field.cost
        when "vmd_per_item"
          c.custom_vmd_per_item_fee += field.amount
          c.custom_vmd_per_item_fee_cost += field.cost
        when "vmd_volume_bp"
          c.custom_vmd_volume_bp += field.amount
          c.custom_vmd_volume_bp_cost += field.cost
        when "amex_per_item"
          c.custom_amex_per_item += field.amount
          c.custom_amex_per_item_cost += field.cost
        when "amex_volume_bp"
          c.custom_amex_volume_bp += field.amount
          c.custom_amex_volume_bp_cost += field.cost
        when "pin_per_item"
          c.custom_pin_per_item += field.amount
          c.custom_pin_per_item_cost += field.cost
        when "pin_volume_bp"
          c.custom_pin_volume_bp += field.amount
          c.custom_pin_volume_bp_cost += field.cost
        when "sales_bonus"
          c.custom_sales_bonus += field.amount
          c.custom_sales_bonus_costs += field.cost
        when "one_time_fee"
          c.custom_one_time_fee += field.amount
          c.custom_one_time_fee_costs += field.cost
        when "service_fee"
          c.service_fee += field.amount
        end
      end
      if c.custom_vmd_per_item_fee > 0
        c.custom_total_vmd_per_item_fees = (s.vmd_trans * c.custom_vmd_per_item_fee)
        c.custom_vmd_per_item_fee_costs = (s.vmd_trans * c.custom_vmd_per_item_fee_cost)
      end
      if c.custom_vmd_volume_bp > 0
        c.custom_total_vmd_volume_bp_fees = (s.vmd_vol * ( c.custom_vmd_volume_bp.to_f / 10000 ) )
        c.custom_vmd_volume_bp_costs = (s.vmd_vol * ( c.custom_vmd_volume_bp_cost.to_f / 10000 ) )
      end
      if c.custom_amex_per_item > 0
        c.custom_total_amex_per_item_fees = (s.amex_trans * c.custom_amex_per_item)
        c.custom_amex_per_item_costs = (s.amex_trans * c.custom_amex_per_item_cost)
      end
      if c.custom_amex_volume_bp > 0
        c.custom_total_amex_volume_bp_fees = (s.amex_vol * ( c.custom_amex_volume_bp.to_f / 10000 ) )
        c.custom_amex_volume_bp_costs = (s.amex_vol * ( c.custom_amex_volume_bp_cost.to_f / 10000 ) )
      end
      if c.custom_pin_per_item > 0
        c.custom_total_pin_per_item_fees = (s.debit_trans * c.custom_pin_per_item)
        c.custom_pin_per_item_costs = (s.debit_trans * c.custom_pin_per_item_cost)
      end
      if c.custom_pin_volume_bp > 0
        c.custom_total_pin_volume_bp_fees = (s.debit_vol * ( c.custom_pin_volume_bp.to_f / 10000 ) )
        c.custom_pin_volume_bp_costs = (s.debit_vol * ( c.custom_pin_volume_bp_cost.to_f / 10000 ) )
      end
      if c.service_fee > 0
        c.service_fees = s.total_vol * (c.service_fee.to_f / 10000)
      end
    end
  end

  def set_all_custom_field_c_values_to_zero(c)
    c.custom_monthly_fees = 0
    c.custom_monthly_fee_costs = 0
    c.custom_annual_fees = 0
    c.custom_annual_fee_costs = 0
    c.custom_vmd_per_item_fee = 0
    c.custom_vmd_per_item_fee_cost = 0
    c.custom_vmd_volume_bp = 0
    c.custom_vmd_volume_bp_cost = 0
    c.custom_amex_per_item = 0
    c.custom_amex_per_item_cost = 0
    c.custom_amex_volume_bp = 0
    c.custom_amex_volume_bp_cost = 0
    c.custom_pin_per_item = 0
    c.custom_pin_per_item_cost = 0
    c.custom_pin_volume_bp = 0
    c.custom_pin_volume_bp_cost = 0
    c.custom_sales_bonus = 0
    c.custom_sales_bonus_costs = 0
    c.custom_one_time_fee = 0
    c.custom_one_time_fee_costs  = 0
    c.custom_total_vmd_per_item_fees = 0
    c.custom_vmd_per_item_fee_costs = 0
    c.custom_total_vmd_volume_bp_fees = 0
    c.custom_vmd_volume_bp_costs = 0
    c.custom_total_amex_per_item_fees = 0
    c.custom_amex_per_item_costs = 0
    c.custom_total_amex_volume_bp_fees = 0
    c.custom_amex_volume_bp_costs = 0
    c.custom_total_pin_per_item_fees = 0
    c.custom_pin_per_item_costs = 0
    c.custom_total_pin_volume_bp_fees = 0
    c.custom_pin_volume_bp_costs = 0
    c.service_fee = 0
  end

  def pricing_wizard_no_nill(c)
    if c.monthly_pci_fees == nil
      c.monthly_pci_fees = 0
    end
  end

  def comparison_no_nil(c)
    if c.bp_mark_up == nil
      c.bp_mark_up = 0
    end
    if c.per_item_fee == nil
      c.per_item_fee = 0
    end
    if c.amex_bp_mark_up == nil
      c.amex_bp_mark_up = 0
    end
    if c.amex_per_item_fee == nil
      c.amex_per_item_fee = 0
    end
    if c.pin_debit_per_item_fee == nil
      c.pin_debit_per_item_fee = 0
    end
    if c.monthly_fees == nil
      c.monthly_fees = 0
    end
    if c.per_batch_fee == nil
      c.per_batch_fee = 0
    end
    if c.monthly_pci_fees == nil
      c.monthly_pci_fees = 0
    end
    if c.annual_pci_fees == nil
      c.annual_pci_fees = 0
    end
    if c.application_fee == nil
      c.application_fee = 0
    end
    if c.annual_fee == nil
      c.annual_fee = 0
    end
    if c.monthly_debit_fee == nil
      c.monthly_debit_fee = 0
    end
    if c.next_day_funding_fee == nil
      c.next_day_funding_fee = 0
    end

  end
end
