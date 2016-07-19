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
  end

  # GET /statements/1/edit
  def edit
  end

  # POST /statements
  # POST /statements.json
  def create
    @statement = @prospect.statements.new(statement_params)
    @statement.vmd_vol = @statement.total_vol - @statement.amex_vol - @statement.check_card_vol - @statement.debit_vol
      
    @statement.vmd_avg_ticket = @statement.avg_ticket
    @statement.amex_avg_ticket = @statement.avg_ticket
    @statement.debit_avg_ticket = @statement.avg_ticket
    @statement.check_card_avg_ticket = @statement.avg_ticket
    @statement.batches = 30
    @statement.vmd_trans = @statement.vmd_vol / @statement.vmd_avg_ticket
    @statement.amex_trans = @statement.amex_vol / @statement.amex_avg_ticket
    @statement.debit_trans = @statement.debit_vol / @statement.debit_avg_ticket
    @statement.check_card_trans = @statement.check_card_vol / @statement.check_card_avg_ticket
    @total_vmd_check_card_trans = @statement.check_card_trans + @statement.vmd_trans
    @total_vmd_check_card_vol = @statement.vmd_vol - @statement.amex_vol - @statement.debit_vol

    general_cost("debit", @statement.avg_ticket)
    @statement.debit_network_fees = ((@statement.debit_trans * @cost.per_item_value) + (@statement.debit_vol * (@cost.percentage_value/100)))
    general_cost("check_card", @statement.avg_ticket)
    @statement.check_card_interchange = ((@statement.check_card_trans * @cost.per_item_value) + (@statement.check_card_vol * (@cost.percentage_value/100)))
    
    interchange_cost(@prospect.description_id,  @total_vmd_check_card_trans, @total_vmd_check_card_vol)
    @statement.vmd_interchange = @costs


    amex_cost("amex", @prospect.amex_business_type, @statement.avg_ticket)
    @statement.amex_interchange = ((@statement.amex_trans * @cost.per_item_value) + (@statement.amex_vol * (@cost.percentage_value/100)))
    @statement.interchange = @statement.vmd_interchange + @statement.check_card_interchange + @statement.amex_interchange + @statement.debit_network_fees

    respond_to do |format|
      if @statement.save
        format.html { redirect_to edit_prospect_statement_path(@prospect, @statement), notice: 'Statement was successfully created.' }
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
      
end
