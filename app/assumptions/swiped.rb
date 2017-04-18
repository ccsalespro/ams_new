class Swiped < Assumption
	def calculate
	@swiped_volume = 0
  @swiped_costs = 0 
  @vs_volume = 0
  @mc_volume = 0
  @ds_volume = 0
      @inttableitems.each do |item|
        @inttype = Inttype.find_by_id(item.inttype_id)
        if @inttype.ecomm != true && @inttype.keyed != true 
          @swiped_volume += item.volume
          @swiped_costs += item.costs
          if @inttype.card_type == "VS"
            @vs_volume += item.volume 
          elsif @inttype.card_type == "MC"
            @mc_volume += item.volume 
          elsif @inttype.card_type == "DS"
            @ds_volume += item.volume 
          end
        end
      end
      @statement.swiped_vol = @swiped_volume
      @statement.swiped_percent = ( ( @swiped_volume / @statement.vmd_vol ) * 100 )
      @statement.swiped_percent = @statement.swiped_percent
      @statement.swiped_er = @swiped_costs / @swiped_volume

      if @swiped_volume.nonzero?
        @statement.vs_swiped_percentage = @vs_volume / @swiped_volume
        @statement.mc_swiped_percentage = @mc_volume / @swiped_volume
        @statement.ds_swiped_percentage = @ds_volume / @swiped_volume
      else
        @statement.vs_swiped_percentage = 0
        @statement.mc_swiped_percentage = 0
        @statement.ds_swiped_percentage = 0
      end
      
      @statement.vs_swiped_volume = @vs_volume
      @statement.mc_swiped_volume = @mc_volume
      @statement.ds_swiped_volume = @ds_volume
	end
end