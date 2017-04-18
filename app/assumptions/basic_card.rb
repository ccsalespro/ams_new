class BasicCard < Assumption
	def calculate
	@basic_volume = 0
  @basic_costs = 0
  @vs_volume = 0
  @mc_volume = 0
  @ds_volume = 0
      @inttableitems.each do |item|
        @inttype = Inttype.find_by_id(item.inttype_id)
        if @inttype.rewards == false && @inttype.btob == false && @inttype.downgrade == false
          @basic_volume += item.volume
          @basic_costs += item.costs
          if @inttype.card_type == "VS"
            @vs_volume += item.volume 
          elsif @inttype.card_type == "MC"
            @mc_volume += item.volume 
          elsif @inttype.card_type == "DS"
            @ds_volume += item.volume 
          end
        end
      end
      @statement.basic_volume = @basic_volume
      @statement.basic_percent = ( ( @basic_volume / @statement.vmd_vol ) * 100 )
      @statement.basic_volume = @statement.basic_volume
      @statement.basic_er = @basic_costs / @basic_volume
      
      if @basic_volume.nonzero?
        @statement.vs_basic_percentage = @vs_volume / @basic_volume
        @statement.mc_basic_percentage = @mc_volume / @basic_volume
        @statement.ds_basic_percentage = @ds_volume / @basic_volume
      else
        @statement.vs_basic_percentage = 0
        @statement.mc_basic_percentage = 0
        @statement.ds_basic_percentage = 0
      end
      
      @statement.vs_basic_volume = @vs_volume
      @statement.mc_basic_volume = @mc_volume
      @statement.ds_basic_volume = @ds_volume
	end
end