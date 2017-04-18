class RegulatedCheckCard < Assumption
	def calculate
	@check_card_vol_assumption = 0
  @check_card_trans_assumption = 0
  @regulated_costs = 0
  @vs_volume = 0
  @mc_volume = 0
  @ds_volume = 0    
    @inttableitems.each do |item|
    @inttype = Inttype.find_by_id(item.inttype_id)
    	if @inttype.regulated == true && @inttype.debit == true
        	@check_card_vol_assumption += item.volume
        	@check_card_trans_assumption += item.transactions
          @regulated_costs += item.costs
          if @inttype.card_type == "VS"
            @vs_volume += item.volume 
          elsif @inttype.card_type == "MC"
            @mc_volume += item.volume 
          elsif @inttype.card_type == "DS"
            @ds_volume += item.volume 
          end
        end
      end
      
      @check_card_trans_assumption
      @check_card_vol_assumption
      @statement.check_card_trans = @check_card_trans_assumption
      @statement.check_card_vol = @check_card_vol_assumption
      @statement.check_card_percentage = ( ( @check_card_vol_assumption / @statement.vmd_vol) * 100 )
      @statement.check_card_percentage = @statement.check_card_percentage
      @statement.regulated_er = @regulated_costs / @check_card_vol_assumption

      if @check_card_vol_assumption.nonzero?
        @statement.vs_check_card_percentage = @vs_volume / @check_card_vol_assumption
        @statement.mc_check_card_percentage = @mc_volume / @check_card_vol_assumption
        @statement.ds_check_card_percentage = @ds_volume / @check_card_vol_assumption
      else
        @statement.vs_check_card_percentage = 0
        @statement.mc_check_card_percentage = 0
        @statement.ds_check_card_percentage = 0
      end
      
      @statement.vs_check_card_volume = @vs_volume
      @statement.mc_check_card_volume = @mc_volume
      @statement.ds_check_card_volume = @ds_volume
	end
end