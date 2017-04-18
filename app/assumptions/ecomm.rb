class Ecomm < Assumption
	def calculate
	@ecomm_volume = 0
  @vs_volume = 0
  @mc_volume = 0
  @ds_volume = 0
      @inttableitems.each do |item|
        @inttype = Inttype.find_by_id(item.inttype_id)
        if @inttype.ecomm == true
          @ecomm_volume += item.volume
          if @inttype.card_type == "VS"
            @vs_volume += item.volume 
          elsif @inttype.card_type == "MC"
            @mc_volume += item.volume 
          elsif @inttype.card_type == "DS"
            @ds_volume += item.volume 
          end
        end
      end
      @statement.ecomm_vol = @ecomm_volume
      @statement.ecomm_percentage = ( ( @ecomm_volume / @statement.vmd_vol ) * 100 )
      @statement.ecomm_percentage = @statement.ecomm_percentage

      if @ecomm_volume.nonzero?
        @statement.vs_ecomm_percentage = @vs_volume / @ecomm_volume
        @statement.mc_ecomm_percentage = @mc_volume / @ecomm_volume
        @statement.ds_ecomm_percentage = @ds_volume / @ecomm_volume
      else
        @statement.vs_ecomm_percentage = 0
        @statement.mc_ecomm_percentage = 0
        @statement.ds_ecomm_percentage = 0
      end

      @statement.vs_ecomm_volume = @vs_volume
      @statement.mc_ecomm_volume = @mc_volume
      @statement.ds_ecomm_volume = @ds_volume
	end
end