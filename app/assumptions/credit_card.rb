class CreditCard < Assumption
  def calculate
  @credit_volume = 0
  @credit_costs = 0
  @vs_volume = 0
  @mc_volume = 0
  @ds_volume = 0
      @inttableitems.each do |item|
        @inttype = Inttype.find_by_id(item.inttype_id)
        if @inttype.debit != true 
          @credit_volume += item.volume
          @credit_costs += item.costs
          if @inttype.card_type == "VS"
            @vs_volume += item.volume 
          elsif @inttype.card_type == "MC"
            @mc_volume += item.volume 
          elsif @inttype.card_type == "DS"
            @ds_volume += item.volume 
          end
        end
      end
      @statement.credit_volume = @credit_volume
      @statement.credit_percent = ( ( @credit_volume / @statement.vmd_vol ) * 100 )
      @statement.credit_percent = @statement.credit_percent
      @statement.credit_card_er = @credit_costs / @credit_volume
      
      if @credit_volume.nonzero?
        @statement.vs_credit_percentage = @vs_volume / @credit_volume
        @statement.mc_credit_percentage = @mc_volume / @credit_volume
        @statement.ds_credit_percentage = @ds_volume / @credit_volume
      else
        @statement.vs_credit_percentage = 0
        @statement.mc_credit_percentage = 0
        @statement.ds_credit_percentage = 0
      end

      @statement.vs_credit_volume = @vs_volume
      @statement.mc_credit_volume = @mc_volume
      @statement.ds_credit_volume = @ds_volume
  end
end