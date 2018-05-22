module Marketing
  class StatementsController < BaseController
    def new
      @prospect = Prospect.find(params[:prospect_id])
      @statement = @prospect.statements.new
      new_average_ticket_calc(@prospect.description_id)
      @statement.avg_ticket = @avg_ticket_calculation
    end

    def create
      @prospect = Prospect.find(params[:prospect_id])

      @statement = @prospect.statements.new(statement_params)

      @algorithm = Algorithm.new(@statement, @prospect)
      @inttableitems = @algorithm.calculate

      respond_to do |format|
        if @statement.save
          format.html { redirect_to marketing_prospect_statement_comparisons_path(@prospect, @statement) }
        else
          format.html { render :new }
          format.json { render json: @statement.errors, status: :unprocessable_entity }
        end
      end
    end

    def new_average_ticket_calc(description_id)
      @description = Description.find_by_id(description_id)
      @avg_ticket_calculation = @description.avg_ticket
    end

    private
    def statement_params
      params.require(:statement).permit(:ecomm_vol, :ecomm_percentage, :btob_vol, :btob_percentage, :moto_vol, :moto_percentage, :downgrade_vol, :downgrade_percentage, :total_fees, :bathes, :avg_ticket, :check_card_vol, :amex_trans, :amex_vol, :vmd_trans, :vmd_vol, :debit_trans, :debit_vol, :interchange, :statement_month, :business_id, :business_type, :vmd_avg_ticket, :amex_avg_ticket, :debit_avg_ticket, :check_card_avg_ticket, :check_card_trans, :debit_network_fees, :check_card_interchange, :amex_interchange, :vmd_interchange, :total_vol, :check_card_percentage, :unreg_debit_percentage)
    end
  end
end
