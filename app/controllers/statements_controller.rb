class StatementsController < ApplicationController
  before_action :set_statement, only: [:show, :edit, :update, :destroy, :unregulated_check_card_update, :regulated_check_card_update, :downgrade_edit, :check_card_update, :btob_update, :moto_update, :interchange_update, :ecomm_update]
  before_filter :load_prospect, except: [:downgrade_update]
  before_action :authenticate_user!
  
  # GET /statements
  # GET /statements.json
  def index
    @statements = @prospect.statements.all
  end

  def downgrade_edit
    @statement.form_name = "downgrade"
    @statement.form_percentage = @statement.downgrade_percentage
    @statement.form_volume = @statement.downgrade_vol 
    @statement.save
  end

  def moto_update
    @statement.form_name = "moto" 
    @statement.form_volume = @statement.moto_vol
    @statement.form_percentage = @statement.moto_percentage
    @statement.save
  end

  def btob_update
    @statement.form_name = "btob" 
    @statement.form_volume = @statement.btob_vol
    @statement.form_percentage = @statement.btob_percentage
    @statement.save
  end

  def ecomm_update
    @statement.form_name = "ecomm" 
    @statement.form_volume = @statement.ecomm_vol
    @statement.form_percentage = @statement.ecomm_percentage
    @statement.save
  end

  def unregulated_check_card_update
    @statement.form_name = "unregulated_check_card"
    @statement.form_volume = @statement.unreg_debit_vol
    @statement.form_percentage = @statement.unreg_debit_percentage  
    @statement.save
  end

  def regulated_check_card_update
    @statement.form_name = "regulated_check_card"
    @statement.form_volume = @statement.check_card_vol
    @statement.form_percentage = @statement.check_card_percentage 
    @statement.save
  end

  def interchange_update
    @statement.form_name = "interchange" 
    @statement.save
  end

  # GET /statements/1
  # GET /statements/1.json
  def show
    if @statement.downgrade_vol == nil
      set_downgrades
      set_moto
      set_ecomm
      set_btob
      set_unregulated_check_card
      set_regulated_check_card
    end
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
    downgrade_table_adjust
    moto_table_adjust
    btob_table_adjust
    ecomm_table_adjust
    check_card_table_adjust
    unreg_debit_table_adjust
    update_total_vmd_interchange

    @statement.interchange = @statement.vmd_interchange + @statement.amex_interchange + @statement.debit_network_fees
    
    set_downgrades
    set_moto
    set_ecomm
    set_btob
    set_unregulated_check_card
    set_regulated_check_card
    

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

  end

  # POST /statements
  # POST /statements.json
  def create

    @statement = @prospect.statements.new(statement_params)

    respond_to do |format|
      if @statement.save
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
          interchange_cost(@intcalcitems, @statement.id,  @statement.vmd_trans, @statement.vmd_vol)
          @statement.vmd_interchange = @costs
          set_downgrades
          set_moto
          set_ecomm
          set_btob
          set_unregulated_check_card
          set_regulated_check_card


        @statement.interchange = @statement.vmd_interchange + @statement.amex_interchange + @statement.debit_network_fees
        
        

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
        @statement.save
        
        format.html { redirect_to prospect_statement_path(@prospect, @statement), notice: 'Statement was successfully created.' }
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
      params.require(:statement).permit(:ecomm_vol, :ecomm_percentage, :btob_vol, :btob_percentage, :moto_vol, :moto_percentage, :downgrade_vol, :downgrade_percentage, :total_fees, :bathes, :avg_ticket, :check_card_vol, :amex_trans, :amex_vol, :vmd_trans, :vmd_vol, :debit_trans, :debit_vol, :interchange, :statement_month, :business_id, :business_type, :vmd_avg_ticket, :amex_avg_ticket, :debit_avg_ticket, :check_card_avg_ticket, :check_card_trans, :debit_network_fees, :check_card_interchange, :amex_interchange, :vmd_interchange, :total_vol, :check_card_percentage, :unreg_debit_percentage)
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
          if @intcalcitems.any? {|i| i.inttype_id == item.inttype_id}
            @intcalcitem = @intcalcitems.find {|i| i.inttype_id == item.inttype_id}
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
      end
      return @intcalcitems
    end

    def interchange_cost(intcalcitems, id, total_transactions, total_vol)
      @intcalcitems = intcalcitems
      @inttableitems = []
         
     @intcalcitems.each do |item|
        @inttype = Inttype.find_by_id(item.inttype_id)   
        @inttableitem = @statement.inttableitems.build
        @inttableitem.inttype_id = item.inttype_id
        @inttableitem.volume = total_vol * item.inttype_percent
        @total_avg_ticket = total_vol.to_f / total_transactions.to_f
        @inttableitem.avg_ticket = @total_avg_ticket * item.avg_ticket_variance
        @inttableitem.transactions = @inttableitem.volume / @inttableitem.avg_ticket
        @inttableitem.costs = ( @inttableitem.transactions * @inttype.per_item ) + ( @inttableitem.volume.to_f * @inttype.percent )
        @inttableitems << @inttableitem
      end
      @costs = 0
      @inttableitems.each do |item|
        @costs += item.costs
        item.save
      end
      @costs
    end

    def update_total_vmd_interchange
      @inttableitems = Inttableitem.where(statement_id: @statement.id)
      @costs = 0
      @inttableitems.each do |item|
        @costs += item.costs
      end
      @statement.vmd_interchange = @costs
      @statement.save
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

     def set_regulated_check_card
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
      @statement.check_card_trans = @check_card_trans_assumption.round(0)
      @statement.check_card_vol = @check_card_vol_assumption.round(2)
      @statement.check_card_percentage = ( ( @check_card_vol_assumption / @statement.vmd_vol) * 100 )
      @statement.check_card_percentage = @statement.check_card_percentage.round(2)
      @statement.save
    end

    def set_downgrades
      @inttableitems = Inttableitem.where(statement_id: @statement.id)
      @downgrade_volume = 0
      @inttableitems.each do |item|
        @inttype = Inttype.find_by_id(item.inttype_id)
        if @inttype.downgrade == true 
          @downgrade_volume += item.volume
        end
      end
      @statement.downgrade_vol = @downgrade_volume.round(2)
      @statement.downgrade_percentage = ( ( @downgrade_volume / @statement.vmd_vol ) * 100 )
      @statement.downgrade_percentage = @statement.downgrade_percentage.round(2)
      @statement.save
    end

    def set_moto
      @inttableitems = Inttableitem.where(statement_id: @statement.id)
      @moto_volume = 0
      @inttableitems.each do |item|
        @inttype = Inttype.find_by_id(item.inttype_id)
        if @inttype.keyed == true 
          @moto_volume += item.volume
        end
      end
      @statement.moto_vol = @moto_volume.round(2)
      @statement.moto_percentage = ( ( @moto_volume / @statement.vmd_vol ) * 100 )
      @statement.moto_percentage = @statement.moto_percentage.round(2)
      @statement.save
    end

    def set_unregulated_check_card
      @inttableitems = Inttableitem.where(statement_id: @statement.id)
      @unregulated_volume = 0
      @inttableitems.each do |item|
        @inttype = Inttype.find_by_id(item.inttype_id)
        if @inttype.debit == true && @inttype.regulated == false
          @unregulated_volume += item.volume
        end
      end
      @statement.unreg_debit_vol = @unregulated_volume.round(2)
      @statement.unreg_debit_percentage = ( ( @unregulated_volume / @statement.vmd_vol ) * 100 )
      @statement.unreg_debit_percentage = @statement.unreg_debit_percentage.round(2)
      @statement.save
    end

    def set_ecomm
      @inttableitems = Inttableitem.where(statement_id: @statement.id)
      @ecomm_volume = 0
      @inttableitems.each do |item|
        @inttype = Inttype.find_by_id(item.inttype_id)
        if @inttype.ecomm == true
          @ecomm_volume += item.volume
        end
      end
      @statement.ecomm_vol = @ecomm_volume.round(2)
      @statement.ecomm_percentage = ( ( @ecomm_volume / @statement.vmd_vol ) * 100 )
      @statement.ecomm_percentage = @statement.ecomm_percentage.round(2)
      @statement.save
    end

    def set_btob
      @inttableitems = Inttableitem.where(statement_id: @statement.id)
      @btob_volume = 0
      @inttableitems.each do |item|
        @inttype = Inttype.find_by_id(item.inttype_id)
        if @inttype.btob == true
          @btob_volume += item.volume
        end
      end
      @statement.btob_vol = @btob_volume.round(2)
      @statement.btob_percentage = ( ( @btob_volume / @statement.vmd_vol ) * 100 )
      @statement.btob_percentage = @statement.btob_percentage.round(2)
      @statement.save
    end

    def downgrade_table_adjust
      if @statement.form_name == "downgrade"
        if @statement.form_volume == 0
          @statement.downgrade_vol = ( @statement.vmd_vol * ( @statement.downgrade_percentage / 100) )
          @statement.save
          @change = @statement.moto_vol - @statement.form_volume
          @non_change = (@statement.vmd_vol - @statement.moto_vol) - (@statement.vmd_vol - @statement.form_volume)
          @inttableitems = Inttableitem.where(statement_id: @statement.id)
          @inttypes = Inttype.where(id: [35, 44, 76, 77, 150, 204])
          @non_percentage_change = ( @non_change / (@statement.vmd_vol - @statement.form_volume))
          @inttableitems.each do |item|
          @inttype = Inttype.find_by_id(item.inttype_id)
             item.volume += ( item.volume * @non_percentage_change )
             item.transactions = item.volume / item.avg_ticket
             item.costs = (item.volume * @inttype.percent) + (item.transactions * @inttype.per_item)
             item.save
          end
            @inttypes.each do |type|
            @inttableitem = Inttableitem.new 
            @inttableitem.inttype_id = type.id
            @inttableitem.statement_id = @statement.id
            @inttableitem.avg_ticket = @statement.avg_ticket
            @inttableitem.volume = @change / 6
            @inttableitem.transactions = @inttableitem.volume / @inttableitem.avg_ticket
            @inttableitem.costs = ( @inttableitem.volume * type.percent ) + ( @inttableitem.transactions * type.per_item)
            @inttableitem.save
          end
        else
          @statement.downgrade_vol = ( @statement.vmd_vol * ( @statement.downgrade_percentage / 100) )
          @statement.save
          @change = @statement.downgrade_vol - @statement.form_volume
          @non_downgrade_change = (@statement.vmd_vol - @statement.downgrade_vol) - (@statement.vmd_vol - @statement.form_volume)
          @inttableitems = Inttableitem.where(statement_id: @statement.id)
          @downgrade_percentage_change = ( @change / @statement.form_volume )
          @non_downgrade_percentage_change = ( @non_downgrade_change / (@statement.vmd_vol - @statement.form_volume))
          @inttableitems.each do |item|
          @inttype = Inttype.find_by_id(item.inttype_id)
          if @inttype.downgrade == true
            item.volume += ( item.volume * @downgrade_percentage_change )
            item.transactions = item.volume / item.avg_ticket
            item.costs = ((item.volume * @inttype.percent ) + (item.transactions * @inttype.per_item))
            item.save
          else
             item.volume += ( item.volume * @non_downgrade_percentage_change )
             item.transactions = item.volume / item.avg_ticket
             item.costs = ((item.volume * @inttype.percent) + (item.transactions * @inttype.per_item))
             item.save
          end
        end
      end
    end
  end

  def moto_table_adjust
    if @statement.form_name == "moto"
      if @statement.form_volume == 0
        @statement.moto_vol = ( @statement.vmd_vol * ( @statement.moto_percentage / 100) )
        @statement.save
        @change = @statement.moto_vol - @statement.form_volume
        @non_change = (@statement.vmd_vol - @statement.moto_vol) - (@statement.vmd_vol - @statement.form_volume)
        @inttableitems = Inttableitem.where(statement_id: @statement.id)
        @inttypes = Inttype.where(id: [57, 58, 59, 146, 164, 165])
        @non_percentage_change = ( @non_change / (@statement.vmd_vol - @statement.form_volume))
        @inttableitems.each do |item|
        @inttype = Inttype.find_by_id(item.inttype_id)
           item.volume += ( item.volume * @non_percentage_change )
           item.transactions = item.volume / item.avg_ticket
           item.costs = (item.volume * @inttype.percent) + (item.transactions * @inttype.per_item)
           item.save
        end
        @inttypes.each do |type|
          @inttableitem = Inttableitem.new 
          @inttableitem.inttype_id = type.id
          @inttableitem.statement_id = @statement.id
          @inttableitem.avg_ticket = @statement.avg_ticket
          @inttableitem.volume = @change / 6
          @inttableitem.transactions = @inttableitem.volume / @inttableitem.avg_ticket
          @inttableitem.costs = ( @inttableitem.volume * type.percent ) + ( @inttableitem.transactions * type.per_item)
          @inttableitem.save
        end
      else
        @statement.moto_vol = ( @statement.vmd_vol * ( @statement.moto_percentage / 100) )
        @statement.save
        @change = @statement.moto_vol - @statement.form_volume
        @non_change = (@statement.vmd_vol - @statement.moto_vol) - (@statement.vmd_vol - @statement.form_volume)
        @inttableitems = Inttableitem.where(statement_id: @statement.id)
        @percentage_change = ( @change / @statement.form_volume )
        @non_percentage_change = ( @non_change / (@statement.vmd_vol - @statement.form_volume))
        @inttableitems.each do |item|
        @inttype = Inttype.find_by_id(item.inttype_id)
          if @inttype.keyed == true
            item.volume += ( item.volume * @percentage_change )
            item.transactions = item.volume / item.avg_ticket
            item.costs = (item.volume * @inttype.percent) + (item.transactions * @inttype.per_item)
            item.save
          else
             item.volume += ( item.volume * @non_percentage_change )
             item.transactions = item.volume / item.avg_ticket
             item.costs = (item.volume * @inttype.percent) + (item.transactions * @inttype.per_item)
             item.save
          end
        end
      end
    end
  end

   def ecomm_table_adjust
    if @statement.form_name == "ecomm"
      if @statement.form_volume == 0
        @statement.ecomm_vol = ( @statement.vmd_vol * ( @statement.ecomm_percentage / 100) )
        @statement.save
        @change = @statement.ecomm_vol - @statement.form_volume
        @non_change = (@statement.vmd_vol - @statement.ecomm_vol) - (@statement.vmd_vol - @statement.form_volume)
        @inttableitems = Inttableitem.where(statement_id: @statement.id)
        @inttypes = Inttype.where(id: [49, 50])
        @non_percentage_change = ( @non_change / (@statement.vmd_vol - @statement.form_volume))
        @inttableitems.each do |item|
        @inttype = Inttype.find_by_id(item.inttype_id)
           item.volume += ( item.volume * @non_percentage_change )
           item.transactions = item.volume / item.avg_ticket
           item.costs = (item.volume * @inttype.percent) + (item.transactions * @inttype.per_item)
           item.save
        end
        @inttypes.each do |type|
          @inttableitem = Inttableitem.new 
          @inttableitem.inttype_id = type.id
          @inttableitem.statement_id = @statement.id
          @inttableitem.avg_ticket = @statement.avg_ticket
          @inttableitem.volume = @change / 2
          @inttableitem.transactions = @inttableitem.volume / @inttableitem.avg_ticket
          @inttableitem.costs = ( @inttableitem.volume * type.percent ) + ( @inttableitem.transactions * type.per_item)
          @inttableitem.save
        end
      else
        @statement.ecomm_vol = ( @statement.vmd_vol * ( @statement.ecomm_percentage / 100) )
        @statement.save
        @change = @statement.ecomm_vol - @statement.form_volume
        @non_change = (@statement.vmd_vol - @statement.ecomm_vol) - (@statement.vmd_vol - @statement.form_volume)
        @inttableitems = Inttableitem.where(statement_id: @statement.id)
        @percentage_change = ( @change / @statement.form_volume )
        @non_percentage_change = ( @non_change / (@statement.vmd_vol - @statement.form_volume))
        @inttableitems.each do |item|
        @inttype = Inttype.find_by_id(item.inttype_id)
          if @inttype.ecomm == true
            item.volume += ( item.volume * @percentage_change )
            item.transactions = item.volume / item.avg_ticket
            item.costs = (item.volume * @inttype.percent) + (item.transactions * @inttype.per_item)
            item.save
          else
             item.volume += ( item.volume * @non_percentage_change )
             item.transactions = item.volume / item.avg_ticket
             item.costs = (item.volume * @inttype.percent) + (item.transactions * @inttype.per_item)
             item.save
          end
        end
      end
    end
  end

  def btob_table_adjust
    if @statement.form_name == "btob"
      @statement.btob_vol = ( @statement.vmd_vol * ( @statement.btob_percentage / 100) )
      @statement.save
      @change = @statement.btob_vol - @statement.form_volume
      @non_change = (@statement.vmd_vol - @statement.btob_vol) - (@statement.vmd_vol - @statement.form_volume)
    @inttableitems = Inttableitem.where(statement_id: @statement.id)
    @percentage_change = ( @change / @statement.form_volume )
    @non_percentage_change = ( @non_change / (@statement.vmd_vol - @statement.form_volume))
    @inttableitems.each do |item|
      @inttype = Inttype.find_by_id(item.inttype_id)
      if @inttype.btob == true
        item.volume += ( item.volume * @percentage_change )
        item.transactions = item.volume / item.avg_ticket
        item.costs = (item.volume * @inttype.percent) + (item.transactions * @inttype.per_item)
        item.save
      else
         item.volume += ( item.volume * @non_percentage_change )
         item.transactions = item.volume / item.avg_ticket
         item.costs = (item.volume * @inttype.percent) + (item.transactions * @inttype.per_item)
         item.save
      end
     end
    end
  end

  def check_card_table_adjust
    if @statement.form_name == "regulated_check_card"
      @statement.check_card_vol = ( @statement.vmd_vol * ( @statement.check_card_percentage / 100) )
      @statement.save
      @change = @statement.check_card_vol - @statement.form_volume
      @non_change = (@statement.vmd_vol - @statement.check_card_vol) - (@statement.vmd_vol - @statement.form_volume)
    @inttableitems = Inttableitem.where(statement_id: @statement.id)
    @percentage_change = ( @change / @statement.form_volume )
    @non_percentage_change = ( @non_change / (@statement.vmd_vol - @statement.form_volume))
    @inttableitems.each do |item|
      @inttype = Inttype.find_by_id(item.inttype_id)
      if @inttype.regulated == true
        item.volume += ( item.volume * @percentage_change )
        item.transactions = item.volume / item.avg_ticket
        item.costs = (item.volume * @inttype.percent) + (item.transactions * @inttype.per_item)
        item.save
      else
         item.volume += ( item.volume * @non_percentage_change )
         item.transactions = item.volume / item.avg_ticket
         item.costs = (item.volume * @inttype.percent) + (item.transactions * @inttype.per_item)
         item.save
      end
     end
    end
  end

  def unreg_debit_table_adjust
    if @statement.form_name == "unregulated_check_card"
      @statement.unreg_debit_vol = ( @statement.vmd_vol * ( @statement.unreg_debit_percentage / 100) )
      @statement.save
      @change = @statement.unreg_debit_vol - @statement.form_volume
      @non_change = (@statement.vmd_vol - @statement.unreg_debit_vol) - (@statement.vmd_vol - @statement.form_volume)
    @inttableitems = Inttableitem.where(statement_id: @statement.id)
    @percentage_change = ( @change / @statement.form_volume )
    @non_percentage_change = ( @non_change / (@statement.vmd_vol - @statement.form_volume))
    @inttableitems.each do |item|
      @inttype = Inttype.find_by_id(item.inttype_id)
      if @inttype.regulated == false && @inttype.debit == true
        item.volume += ( item.volume * @percentage_change )
        item.transactions = item.volume / item.avg_ticket
        item.costs = (item.volume * @inttype.percent) + (item.transactions * @inttype.per_item)
        item.save
      else
         item.volume += ( item.volume * @non_percentage_change )
         item.transactions = item.volume / item.avg_ticket
         item.costs = (item.volume * @inttype.percent) + (item.transactions * @inttype.per_item)
         item.save
      end
     end
    end
  end


end