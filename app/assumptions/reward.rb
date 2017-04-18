class Reward < Assumption
	def calculate
	@rewards_volume = 0
  @rewards_costs = 0
  @vs_volume = 0
  @mc_volume = 0
  @ds_volume = 0
      @inttableitems.each do |item|
        @inttype = Inttype.find_by_id(item.inttype_id)
        if @inttype.rewards == true
          @rewards_volume += item.volume
          @rewards_costs += item.costs
          if @inttype.card_type == "VS"
            @vs_volume += item.volume 
          elsif @inttype.card_type == "MC"
            @mc_volume += item.volume 
          elsif @inttype.card_type == "DS"
            @ds_volume += item.volume 
          end
        end
      end
      @statement.rewards_volume = @rewards_volume
      @statement.rewards_percent = ( ( @rewards_volume / @statement.vmd_vol ) * 100 )
      @statement.rewards_volume = @statement.rewards_volume
      @statement.rewards_er = @rewards_costs / @rewards_volume

      if @rewards_volume.nonzero?
        @statement.vs_rewards_percentage = @vs_volume / @rewards_volume
        @statement.mc_rewards_percentage = @mc_volume / @rewards_volume
        @statement.ds_rewards_percentage = @ds_volume / @rewards_volume
      else
        @statement.vs_rewards_percentage = 0
        @statement.mc_rewards_percentage = 0
        @statement.ds_rewards_percentage = 0
      end

      @statement.vs_rewards_volume = @vs_volume
      @statement.mc_rewards_volume = @mc_volume
      @statement.ds_rewards_volume = @ds_volume
	end
end