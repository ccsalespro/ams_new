class StatementsController < ApplicationController
  before_action :set_statement, only: [:show, :edit, :update, :destroy]
  before_filter :load_prospect
  before_action :authenticate_user!
  
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
    average_ticket_calc(@prospect.description_id)
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
    
      
    if @statement.amex_vol == nil || 0
      @statement.amex_vol = 0
      @statement.amex_trans = 0
      @statement.amex_interchange = 0
    else
      @statement.amex_trans = @statement.amex_vol / @statement.amex_avg_ticket
      amex_cost("amex", @prospect.amex_business_type, @statement.avg_ticket)
      @statement.amex_interchange = ((@statement.amex_trans * @cost.per_item_value) + (@statement.amex_vol * (@cost.percentage_value/100)))
    end
  
    if @statement.debit_vol == nil || 0
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
      interchange_cost(@prospect.description_id,  @statement.vmd_trans, @statement.vmd_vol)
      @statement.vmd_interchange = @costs


    @statement.interchange = @statement.vmd_interchange + @statement.amex_interchange + @statement.debit_network_fees
    
    check_card_assumption
    @statement.check_card_trans = @check_card_trans_assumption
    @statement.check_card_vol = @check_card_vol_assumption

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
        format.html { redirect_to [@prospect, @statement], notice: 'Statement was successfully updated.' }
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
      format.html { redirect_to prospect_statements_path(@prospect), notice: 'Statement was successfully destroyed.' }
      format.json { head :no_content }
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
    def interchange_cost(description_id, total_transactions, total_vol)
      
      # Find all merchants in the database maching the primary description.
      @intcalcitems = Intcalcitem.all.where(["description_id = ?", description_id])
         
     @intcalcitems.each do |item|
        @inttype = Inttype.find_by_id(item.inttype_id)   
        @inttableitem = @statement.inttableitems.build
        @inttableitem.inttype_id = item.inttype_id
        @inttableitem.transactions = total_transactions * item.inttype_percent
        @inttableitem.volume = total_vol * item.inttype_percent
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
    def average_ticket_calc(description_id)
      @intcalcitems = Intcalcitem.all.where(description_id: description_id)
      @total_vol_calc = 0
      @total_trans_calc = 0
        @intcalcitems.each do |item|
          @total_trans_calc += item.transactions
          @total_vol_calc += item.volume
        end
      @avg_ticket_calculation = @total_vol_calc / @total_trans_calc
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

      
end
