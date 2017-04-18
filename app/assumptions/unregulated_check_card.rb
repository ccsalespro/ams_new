class UnregulatedCheckCard < Assumption
	def calculate
	@unregulated_volume = 0
  @unregulated_costs = 0 
  @vs_volume = 0
  @mc_volume = 0
  @ds_volume = 0
      @inttableitems.each do |item|
        @inttype = Inttype.find_by_id(item.inttype_id)
        if @inttype.debit == true && @inttype.regulated == false
          @unregulated_volume += item.volume
          @unregulated_costs += item.costs
          if @inttype.card_type == "VS"
            @vs_volume += item.volume 
          elsif @inttype.card_type == "MC"
            @mc_volume += item.volume 
          elsif @inttype.card_type == "DS"
            @ds_volume += item.volume 
          end
        end
      end
      @statement.unreg_debit_vol = @unregulated_volume
      @statement.unreg_debit_percentage = ( ( @unregulated_volume / @statement.vmd_vol ) * 100 )
      @statement.unreg_debit_percentage = @statement.unreg_debit_percentage
      @statement.unregulated_er = @unregulated_costs / @unregulated_volume

      if @unregulated_volume.nonzero?
        @statement.vs_unreg_debit_percentage = @vs_volume / @unregulated_volume
        @statement.mc_unreg_debit_percentage = @mc_volume / @unregulated_volume
        @statement.ds_unreg_debit_percentage = @ds_volume / @unregulated_volume
      else
        @statement.vs_unreg_debit_percentage = 0
        @statement.mc_unreg_debit_percentage = 0
        @statement.ds_unreg_debit_percentage = 0
      end
      @statement.vs_unreg_debit_volume = @vs_volume
      @statement.mc_unreg_debit_volume = @mc_volume
      @statement.ds_unreg_debit_volume = @ds_volume
    end
end