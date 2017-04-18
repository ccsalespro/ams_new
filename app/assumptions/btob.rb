class Btob < Assumption
	def calculate
	@btob_volume = 0
  @btob_costs = 0
  @vs_volume = 0
  @mc_volume = 0
  @ds_volume = 0
      @inttableitems.each do |item|
        @inttype = Inttype.find_by_id(item.inttype_id)
        if @inttype.btob == true
          @btob_volume += item.volume
          @btob_costs += item.costs
          if @inttype.card_type == "VS"
            @vs_volume += item.volume 
          elsif @inttype.card_type == "MC"
            @mc_volume += item.volume 
          elsif @inttype.card_type == "DS"
            @ds_volume += item.volume 
          end
        end
      end
      @statement.btob_vol = @btob_volume
      @statement.btob_percentage = ( ( @btob_volume / @statement.vmd_vol ) * 100 )
      @statement.btob_percentage = @statement.btob_percentage
      @statement.btob_er = @btob_costs / @btob_volume

      if @btob_volume.nonzero?
        @statement.vs_btob_percentage = @vs_volume / @btob_volume
        @statement.mc_btob_percentage = @mc_volume / @btob_volume
        @statement.ds_btob_percentage = @ds_volume / @btob_volume
      else
        @statement.vs_btob_percentage = 0
        @statement.mc_btob_percentage = 0
        @statement.ds_btob_percentage = 0
      end

      @statement.vs_btob_volume = @vs_volume
      @statement.mc_btob_volume = @mc_volume
      @statement.ds_btob_volume = @ds_volume
	end
end