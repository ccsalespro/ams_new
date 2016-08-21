class StatementsController < ApplicationController
  before_action :set_statement, only: [:show, :edit, :update, :destroy]
  before_filter :load_prospect
  before_action :authenticate_user!
  before_action :require_subscribed
  
  # GET /statements
  # GET /statements.json
  def index
    @statements = @prospect.statements.all
  end

  # GET /statements/1
  # GET /statements/1.json
  def show
  end

  # GET /statements/new
  def new
    @statement = @prospect.statements.new
    new_average_ticket_calc(@prospect.description_id)
    @statement.avg_ticket = @avg_ticket_calculation
  end

  # GET /statements/1/edit
  def edit
  end

  # POST /statements
  # POST /statements.json
  def create

    @statement = @prospect.statements.new(statement_params)
    
    @statement.vmd_avg_ticket = @statement.avg_ticket
    @statement.amex_avg_ticket = @statement.avg_ticket
    @statement.debit_avg_ticket = @statement.avg_ticket
    @statement.batches = 30
    
      
    if @statement.amex_vol == nil
      @statement.amex_vol = 0
      @statement.amex_trans = 0
      @statement.amex_interchange = 0
      @statement.amex_per_item_cost = 0
      @statement.amex_percentage_cost = 0
    else
      @statement.amex_trans = @statement.amex_vol / @statement.amex_avg_ticket
      amex_cost("amex", @prospect.amex_business_type, @statement.avg_ticket)
      @statement.amex_interchange = ((@statement.amex_trans * @cost.per_item_value) + (@statement.amex_vol * (@cost.percentage_value/100)))
      @statement.amex_per_item_cost = @cost.per_item_value
      @statement.amex_percentage_cost = @cost.percentage_value
    end
  
    if @statement.debit_vol == nil
      @statement.debit_vol = 0
      @statement.debit_trans = 0
      @statement.debit_network_fees = 0
    else
      @statement.debit_trans = @statement.debit_vol / @statement.debit_avg_ticket
      general_cost("debit", @statement.avg_ticket)
      @statement.debit_network_fees = ((@statement.debit_trans * @cost.per_item_value) + (@statement.debit_vol * (@cost.percentage_value/100)))
    end

   

      @statement.vmd_vol = @statement.total_vol - @statement.amex_vol - @statement.debit_vol
      @statement.vmd_trans = @statement.vmd_vol / @statement.vmd_avg_ticket
      create_intcalcitems(@prospect.description_id)
      interchange_cost(@statement.id,  @statement.vmd_trans, @statement.vmd_vol)
      @statement.vmd_interchange = @costs


    @statement.interchange = @statement.vmd_interchange + @statement.amex_interchange + @statement.debit_network_fees
    
    check_card_assumption
    @statement.check_card_trans = @check_card_trans_assumption
    @statement.check_card_vol = @check_card_vol_assumption

    card_type_calculation("VS")
    @statement.vs_volume = @volume
    @statement.vs_transactions = @volume / @statement.vmd_avg_ticket
    @statement.vs_fees = @fees

    card_type_calculation("MC")
    @statement.mc_volume = @volume
    @statement.mc_transactions = @volume / @statement.vmd_avg_ticket
    @statement.mc_fees = @fees

   
    card_type_calculation("DS")
    @statement.ds_volume = @volume
    @statement.ds_transactions = @volume / @statement.vmd_avg_ticket
    @statement.ds_fees = @fees

     if @statement.total_fees == nil
      @statement.total_fees = 0
    else
      @statement.total_fees
    end

    respond_to do |format|
      if @statement.save
        format.html { redirect_to prospect_statement_path(@prospect, @statement), notice: 'Statement was successfully created.' }
        format.json { render :edit, status: :created, location: @statement }
      else
        format.html { render :new }
        format.json { render json: @statement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /statements/1
  # PATCH/PUT /statements/1.json
  def update    
    respond_to do |format|
      if @statement.update(statement_params)
        format.html { redirect_to [@prospect, @statement], notice: 'Statement Was Successfully Updated.' }
        format.json { render :show, status: :ok, location: @statement }
      else
        format.html { render :edit }
        format.json { render json: @statement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statements/1
  # DELETE /statements/1.json
  def destroy
    @statement.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render :layout => false }
    end
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
      params.require(:statement).permit(:total_fees, :bathes, :avg_ticket, :check_card_vol, :amex_trans, :amex_vol, :vmd_trans, :vmd_vol, :debit_trans, :debit_vol, :interchange, :statement_month, :business_id, :business_type, :vmd_avg_ticket, :amex_avg_ticket, :debit_avg_ticket, :check_card_avg_ticket, :check_card_trans, :debit_network_fees, :check_card_interchange, :amex_interchange, :vmd_interchange, :total_vol)
    end
    def general_cost(payment_type, avg_ticket)
      @cost = Cost.where(["payment_type = ?", "#{payment_type}"]).where(["low_ticket <= ?", "#{avg_ticket}"]).where(["high_ticket >= ?", "#{avg_ticket}"]).first
    end
    def amex_cost(payment_type, business_type, avg_ticket)
      @cost = Cost.where(["business_type = ?", "#{business_type}"]).where(["payment_type = ?", "#{payment_type}"]).where(["low_ticket <= ?", "#{avg_ticket}"]).where(["high_ticket >= ?", "#{avg_ticket}"]).first
    end
   
    def create_intcalcitems(description_id)
      #16.72 seconds for auto sales
      # Find all merchants in the database maching the primary description.
      @merchants_by_type = Merchant.all.where(["description_id = ?", description_id])
      
      @total_transactions = 0
      @total_volume = 0
      @number_of_merchants = 0
      @intcalcitems = []
      
      @merchants_by_type.each do |merchant|
        @number_of_merchants += 1
      @merchantintitems = merchant.intitems
        @merchantintitems.each do |item|
            @total_transactions += item.transactions
            @total_volume += item.volume
          if Intcalcitem.exists?(:statement_id => @statement.id, :inttype_id => item.inttype_id)
            @intcalcitem = Intcalcitem.find_by(:statement_id => @statement.id, inttype_id: item.inttype_id)
            @intcalcitem.transactions += item.transactions
            @intcalcitem.volume += item.volume
          else
            @intcalcitem = @statement.intcalcitems.build
            @intcalcitem.prospect_id = @prospect.id
            @intcalcitem.inttype_id = item.inttype_id
            @intcalcitem.transactions = item.transactions
            @intcalcitem.volume = item.volume
            @intcalcitem.description_id = @prospect.description_id

            @intcalcitems << @intcalcitem
          end
        end
      end
        @intcalcitems.each do |item|  
        item.inttype_percent = item.volume.to_f / @total_volume.to_f
        @total_avg_ticket = @total_volume.to_f / @total_transactions.to_f
        @intcalc_avg_ticket = item.volume.to_f / item.transactions.to_f
        item.avg_ticket_variance = @intcalc_avg_ticket / @total_avg_ticket
        item.save
      end
    end

    def interchange_cost(id, total_transactions, total_vol)
      
    @intcalcitems = Intcalcitem.all.where(["statement_id = ?", id])
         
     @intcalcitems.each do |item|
        @inttype = Inttype.find_by_id(item.inttype_id)   
        @inttableitem = @statement.inttableitems.build
        @inttableitem.inttype_id = item.inttype_id
        @inttableitem.volume = total_vol * item.inttype_percent
        @total_avg_ticket = total_vol.to_f / total_transactions.to_f
        @inttableitem.avg_ticket = @total_avg_ticket * item.avg_ticket_variance
        @inttableitem.transactions = @inttableitem.volume / @inttableitem.avg_ticket
        @inttableitem.costs = ( @inttableitem.transactions * @inttype.per_item ) + ( @inttableitem.volume.to_f * @inttype.percent )
        @inttableitem.save
      end
      @costs = 0
      @inttableitems = Inttableitem.where(statement_id: @statement.id)
      @inttableitems.each do |item|
        @costs += item.costs
      end
      @costs
    end
    def new_average_ticket_calc(description_id)
      @description = Description.find_by_id(description_id)
      @avg_ticket_calculation = @description.avg_ticket
    end

    def card_type_calculation(card_type_var)
      @inttableitems = Inttableitem.where(statement_id: @statement.id)
      @volume = 0
      @fees = 0
      @inttableitems.each do |item|
        @inttype = Inttype.find_by_id(item.inttype_id)
        if @inttype.card_type == card_type_var 
          @volume += item.volume
          @fees += item.costs
        end
      end
      @volume
      @transactions
      @fees      
    end

     def check_card_assumption
      @inttableitems = Inttableitem.where(statement_id: @statement.id)

      @check_card_vol_assumption = 0
      @check_card_trans_assumption = 0
      
      @inttableitems.each do |item|
        @inttype = Inttype.find_by_id(item.inttype_id)
        if @inttype.per_item == 0.22
        @check_card_vol_assumption += item.volume
        @check_card_trans_assumption += item.transactions
        end
      end
      @check_card_trans_assumption
      @check_card_vol_assumption

    end

     def adjust_inttableitems
      @inttableitems = Inttableitem.where(statement_id: @statement.id)
      #Step 2 - Find the top 5 VS types in terms of volume and rank them by effective rate 
        #Add "effective_rate" to inttableitems and calculate that
      #Step 3 - Repeat step 2 with MC
      #Step 4 - Find the dollar increase / decrease in interchange costs for Visa and Mastercard to make up for dollary amount change
      #Step 5 - iterate through the process of transfering 1 transaction from the highest to lowest interchange category 
        #(or low to high ) for a decrease.
      #Step 6 - repeat step 5 for the second highest and second lowest.
      #Step 7 - Repeat steps 5 and 6 until the number is suprased
      #Step 8 - Undo last iteration in Step 7 and move transactions from the third highest to the 4th or 2nd to close the gap.

    end
end