class Moto < Assumption
	def calculate
	@moto_volume = 0
  @moto_costs = 0
  @vs_volume = 0
  @mc_volume = 0
  @ds_volume = 0
      @inttableitems.each do |item|
        @inttype = Inttype.find_by_id(item.inttype_id)
        if @inttype.keyed == true || @inttype.ecomm == true
          @moto_volume += item.volume
          @moto_costs += item.costs
          if @inttype.card_type == "VS"
            @vs_volume += item.volume 
          elsif @inttype.card_type == "MC"
            @mc_volume += item.volume 
          elsif @inttype.card_type == "DS"
            @ds_volume += item.volume 
          end
        end
      end
      @statement.moto_vol = @moto_volume
      @statement.moto_percentage = ( ( @moto_volume / @statement.vmd_vol ) * 100 )
      @statement.moto_percentage = @statement.moto_percentage

      if @moto_volume.nonzero?
        @statement.vs_moto_percentage = @vs_volume / @moto_volume
        @statement.mc_moto_percentage = @mc_volume / @moto_volume
        @statement.ds_moto_percentage = @ds_volume / @moto_volume
      else
        @statement.vs_moto_percentage = 0
        @statement.mc_moto_percentage = 0
        @statement.ds_moto_percentage = 0
      end

      @statement.vs_moto_volume = @vs_volume
      @statement.mc_moto_volume = @mc_volume
      @statement.ds_moto_volume = @ds_volume
      if @moto_volume > 0
        @statement.moto_er = @moto_costs / @moto_volume
      else
        @statement.moto_er = 0
      end
	end
end