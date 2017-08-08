class StatementsController < ApplicationController
  before_action :set_statement, only: [:volume_update, :increase_interchange, :decrease_interchange, :show, :edit, :method_edit, :brand_edit, :card_type_edit, :check_card_edit, :update, :destroy, :unregulated_check_card_update, :regulated_check_card_update, :downgrade_edit, :check_card_update, :btob_update, :moto_update, :interchange_update, :ecomm_update]
  before_filter :load_prospect, except: [:index, :import, :downgrade_update]
  before_action :authenticate_user!

  def index
    @statements = Statement.all
  end

  def import
    Statement.import(params[:file])
    redirect_to statements_path, notice: "Items imported"
  end
  # GET /statements/1
  # GET /statements/1.json
  def show
    @total = @statement.vmd_vol
    @transactions = @statement.vs_transactions + @statement.mc_transactions + @statement.ds_transactions
    @fees = @statement.vs_fees + @statement.mc_fees + @statement.ds_fees
    @inttableitems = Inttableitem.where(statement_id: @statement.id).where("transactions > ?", 0.99)
    @low_value_costs = 0
    @low_value_volume = 0
    @low_value_transactions = 0
    @low_value_items = Inttableitem.where(statement_id: @statement.id).where("transactions < ?", 1.0)
    if @low_value_items.first != nil  
      @low_value_items.each do |item|
        @low_value_costs += item.costs
        @low_value_volume += item.volume 
        @low_value_transactions += item.transactions
      end

      @low_value_avg_ticket = @low_value_volume / @low_value_transactions
      @low_value_percent_cost = ( @low_value_costs / @low_value_volume ) * 100
    end
    @statement.form_name = "show_edit"
    @statement.save
  end

  def reset_old_statements
    if @statement.created_at < Date.new(2017,3,30)
        @inttableitems = Inttableitem.where(statement_id: @statement.id)
        @inttableitems.destroy_all
        if @statement.total_fees == nil || @statement.total_fees == 0
          @statement.total_fees = @statement.total_vol * 0.035
        end
        @algorithm = Algorithm.new(@statement, @prospect)
        @algorithm.calculate
        @statement.form_name = "primary_form"
        @statement.save
    end
  end

#    @stats = DescriptiveStatistics::Stats.new(@percentages)
#    @stdev = @stats.standard_deviation
#    @mean = @stats.mean
#    @median = @stats.median 
#    @min = @stats.min
#    @max = @stats.max
#    @count = @merchants.count

  def increase_interchange
    @statement.vmd_interchange += (@statement.vmd_vol * 0.00182)
    @algorithm = UpdateAlgorithm.new(@statement, @prospect)
    @algorithm.calculate
    @statement.form_vmd_interchange = @statement.vmd_interchange
    @statement.save
    redirect_to prospect_statement_path(@prospect, @statement)
  end

  def decrease_interchange
    @statement.vmd_interchange -= (@statement.vmd_vol * 0.00182)
    @algorithm = UpdateAlgorithm.new(@statement, @prospect)
    @algorithm.calculate
    @statement.form_vmd_interchange = @statement.vmd_interchange
    @statement.save
    redirect_to prospect_statement_path(@prospect, @statement)
  end

  # GET /statements/new
  def new
    @statement = @prospect.statements.new
    @statement.avg_ticket = new_average_ticket_calc(@prospect.description_id)
  end

  # GET /statements/1/edit
  def edit
    reset_old_statements
    @statement.form_volume = @statement.vmd_vol
    @statement.form_name = "edit"
    @statement.save
  end

  def update 
    @statement.update(statement_params)
    @statement.initial_edit_complete = true
    if @statement.c_batch_fee == nil 
      @statement.c_batch_fee = 0
    end

    if @statement.c_number_of_batches == nil 
      @statement.c_number_of_batches = 0
    end

    if @statement.c_monthly_fees == nil 
      @statement.c_monthly_fees = 0
    end

    if @statement.c_monthly_pci_fee == nil 
      @statement.c_monthly_pci_fee = 0
    end

    if @statement.c_monthly_debit_fee == nil 
      @statement.c_monthly_debit_fee = 0
    end

    if @statement.c_annual_fee == nil 
      @statement.c_annual_fee = 0
    end

    respond_to do |format|
      if @statement.save

        if @statement.form_name == "method_edit"
          @methods = MethodAlgorithm.new(@statement)
          @methods.calculate
        elsif @statement.form_name == "brand_edit"
          @brands = BrandAlgorithm.new(@statement)
          @brands.calculate
        elsif @statement.form_name == "card_type_edit"
          @card_types = CardTypeAlgorithm.new(@statement)
          @card_types.calculate
        elsif @statement.form_name == "check_card_edit"
          @check_cards = CheckCardAlgorithm.new(@statement)
          @check_cards.calculate
        elsif @statement.form_name == "edit"
          @algorithm = FormUpdateAlgorithm.new(@statement, @prospect)
          @algorithm.calculate
        elsif @statement.form_name == "show_edit"
          @cheat_algorithm = CheatAlgorithm.new(@statement)
          @cheat_algorithm.calculate
        end
        @statement.save

        format.html { redirect_to [@prospect, @statement] }
        format.json { render :show, status: :ok, location: @statement }
      else
        format.html { render :edit }
        format.json { render json: @statement.errors, status: :unprocessable_entity }
      end
    end

  end

  # POST /statements
  # POST /statements.json
  def create

    @statement = @prospect.statements.new(statement_params)
    
    respond_to do |format|
      if @statement.save
        @algorithm = Algorithm.new(@statement, @prospect)
        @algorithm.calculate
        @statement.form_name = "primary_form"
        @statement.save
        
        format.html { redirect_to prospect_statement_comparisons_path(@prospect, @statement)}
        format.json { render :edit, status: :created, location: @statement }
      else
        format.html { render :new }
        format.json { render json: @statement.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @statement.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render :layout => false }
    end
  end

  def method_edit
    @statement.form_name = "method_edit"
    @statement.save
  end

  def check_card_edit
    @statement.form_name = "check_card_edit"
    @statement.save
  end

  def brand_edit
    @statement.form_name = "brand_edit"
    @statement.save
  end

  def card_type_edit
    @statement.form_name = "card_type_edit"
    @statement.save
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def load_prospect
      @prospect = Prospect.find(params[:prospect_id])
    end

    def set_statement
      @statement = Statement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def statement_params
      params.require(:statement).permit(:default_basis_points, :default_per_item_fee, :total_passthrough, :c_opt_blue_fees, :c_network_access_fees, :current_interchange, :c_number_of_batches, :c_debit_bp_mark_up, :debit_total_bp_mark_up, :amex_total_bp_mark_up, 
        :debit_total_per_item_fees, :amex_total_per_item_fees, :ds_total_bp_mark_up, :mc_total_bp_mark_up, 
        :vs_total_bp_mark_up, :ds_total_per_item_fees, :mc_total_per_item_fees, :vs_total_per_item_fees, 
        :ds_bp_mark_up, :mc_bp_mark_up, :vs_bp_mark_up, :ds_per_item_fee, :mc_per_item_fee, :vs_per_item_fee, 
        :vs_avg_ticket, :mc_avg_ticket, :ds_avg_ticket, :swiped_percent, :form_vmd_interchange, :vs_percent, 
        :mc_percent, :ds_percent, :credit_percent, :rewards_percent, :basic_percent, :form_percentage, 
        :c_batch_fee, :batches, :prospect_id, :ecomm_vol, :ecomm_percentage, :btob_vol, :btob_percentage, 
        :moto_vol, :moto_percentage, :downgrade_vol, :downgrade_percentage, :total_fees, :bathes, :avg_ticket, 
        :check_card_vol, :amex_trans, :amex_vol, :vmd_trans, :vmd_vol, :debit_trans, :debit_vol, :statement_month, 
        :business_id, :business_type, :vmd_avg_ticket, :amex_avg_ticket, :debit_avg_ticket, :check_card_trans, 
        :debit_network_fees, :amex_interchange, :vmd_interchange, :total_vol, :check_card_percentage, 
        :unreg_debit_percentage, :vs_transactions, :vs_volume, :ds_transactions, :ds_volume, :mc_transactions, 
        :mc_volume, :amex_per_item_cost, :amex_percentage_cost, :c_vmd_bp_mark_up, :c_vmd_per_item_fee, 
        :c_amex_per_item_fee, :c_amex_bp_mark_up, :c_debit_per_item_fee, :c_check_card_access_per_item, 
        :c_check_card_access_percentage, :c_visa_access_per_item, :c_visa_access_percentage, :c_mc_access_per_item, 
        :c_mc_access_percentage, :c_disc_access_per_item, :c_disc_access_percentage, :c_monthly_fees, :c_monthly_pci_fee, 
        :c_monthly_debit_fee, :c_annual_fee, :c_monthly_next_day_funding_fee, :c_other_fees)
    end

    def new_average_ticket_calc(description_id)
      @description = Description.find_by_id(description_id)
      @avg_ticket_calculation = @description.avg_ticket
    end

end