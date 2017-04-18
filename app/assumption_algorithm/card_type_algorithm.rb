class CardTypeAlgorithm < AssumptionAlgorithm
	def calculate
		@inttableitems = Inttableitem.where(statement_id: @statement.id)

		@vs_avg_percent = ((
			@statement.vs_downgrade_percentage + 
			@statement.vs_btob_percentage + 
			@statement.vs_rewards_percentage +
			@statement.vs_basic_percentage) / 4)

		@mc_avg_percent = ((
			@statement.mc_downgrade_percentage + 
			@statement.mc_btob_percentage + 
			@statement.mc_rewards_percentage +
			@statement.mc_basic_percentage) / 4)

		@ds_avg_percent = ((
			@statement.ds_downgrade_percentage + 
			@statement.ds_btob_percentage + 
			@statement.ds_rewards_percentage +
			@statement.ds_basic_percentage) / 4)

		@downgrade_volume_change = (((@statement.downgrade_percentage / 100) * @statement.vmd_vol) - @statement.downgrade_vol)
		@downgrade_percent_change = (@downgrade_volume_change / @statement.downgrade_vol)
		@vs_downgrade_volume_change = @downgrade_volume_change * @vs_avg_percent
		@mc_downgrade_volume_change = @downgrade_volume_change * @mc_avg_percent
		@ds_downgrade_volume_change = @downgrade_volume_change * @ds_avg_percent
		@vs_downgrade_percent_change = @vs_downgrade_volume_change / @statement.vs_downgrade_volume
		@mc_downgrade_percent_change = @mc_downgrade_volume_change / @statement.mc_downgrade_volume
		@ds_downgrade_percent_change = @ds_downgrade_volume_change / @statement.ds_downgrade_volume

		@btob_volume_change = (((@statement.btob_percentage / 100) * @statement.vmd_vol) - @statement.btob_vol)
		@btob_percent_change = (@btob_volume_change / @statement.btob_vol)
		@vs_btob_volume_change = @btob_volume_change * @vs_avg_percent
		@mc_btob_volume_change = @btob_volume_change * @mc_avg_percent
		@ds_btob_volume_change = @btob_volume_change * @ds_avg_percent
		@vs_btob_percent_change = @vs_btob_volume_change / @statement.vs_btob_volume
		@mc_btob_percent_change = @mc_btob_volume_change / @statement.mc_btob_volume
		@ds_btob_percent_change = @ds_btob_volume_change / @statement.ds_btob_volume

		@rewards_volume_change = (((@statement.rewards_percent / 100) * @statement.vmd_vol) - @statement.rewards_volume)
		@rewards_percent_change = (@rewards_volume_change / @statement.rewards_volume)
		@vs_rewards_volume_change = @rewards_volume_change * @vs_avg_percent
		@mc_rewards_volume_change = @rewards_volume_change * @mc_avg_percent
		@ds_rewards_volume_change = @rewards_volume_change * @ds_avg_percent
		@vs_rewards_percent_change = @vs_rewards_volume_change / @statement.vs_rewards_volume
		@mc_rewards_percent_change = @mc_rewards_volume_change / @statement.mc_rewards_volume
		@ds_rewards_percent_change = @ds_rewards_volume_change / @statement.ds_rewards_volume

		@basic_volume_change = (((@statement.basic_percent / 100) * @statement.vmd_vol) - @statement.basic_volume)
		@basic_percent_change = (@basic_volume_change / @statement.basic_volume)
		@vs_basic_volume_change = @basic_volume_change * @vs_avg_percent
		@mc_basic_volume_change = @basic_volume_change * @mc_avg_percent
		@ds_basic_volume_change = @basic_volume_change * @ds_avg_percent
		@vs_basic_percent_change = @vs_basic_volume_change / @statement.vs_basic_volume
		@mc_basic_percent_change = @mc_basic_volume_change / @statement.mc_basic_volume
		@ds_basic_percent_change = @ds_basic_volume_change / @statement.ds_basic_volume
		

		@inttableitems.each do |item|
			@inttype = Inttype.find_by_id(item.inttype_id)
			if @inttype.downgrade == true
				if @inttype.card_type == "VS"
					item.volume = item.volume + (item.volume * @vs_downgrade_percent_change)
				elsif @inttype.card_type == "MC"
					item.volume = item.volume + (item.volume * @mc_downgrade_percent_change)
				elsif @inttype.card_type == "DS"
					item.volume = item.volume + (item.volume * @ds_downgrade_percent_change)
				end
			elsif @inttype.btob == true
				if @inttype.card_type == "VS"
					item.volume = item.volume + (item.volume * @vs_btob_percent_change)
				elsif @inttype.card_type == "MC"
					item.volume = item.volume + (item.volume * @mc_btob_percent_change)
				elsif @inttype.card_type == "DS"
					item.volume = item.volume + (item.volume * @ds_btob_percent_change)
				end
			elsif @inttype.rewards == true
				if @inttype.card_type == "VS"
					item.volume = item.volume + (item.volume * @vs_rewards_percent_change)
				elsif @inttype.card_type == "MC"
					item.volume = item.volume + (item.volume * @mc_rewards_percent_change)
				elsif @inttype.card_type == "DS"
					item.volume = item.volume + (item.volume * @ds_rewards_percent_change)
				end
			else
				if @inttype.card_type == "VS"
					item.volume = item.volume + (item.volume * @vs_basic_percent_change)
				elsif @inttype.card_type == "MC"
					item.volume = item.volume + (item.volume * @mc_basic_percent_change)
				elsif @inttype.card_type == "DS"
					item.volume = item.volume + (item.volume * @ds_basic_percent_change)
				end
			end
			 # Set the total number of transactions for this interchange type based on avg ticket.
	        item.transactions = item.volume / item.avg_ticket

	        # Set total interchange cost for this interchange type.
	        item.costs = ( item.transactions * @inttype.per_item ) + ( item.volume.to_f * @inttype.percent )
			item.save
		end
		@update_fields = UpdateField.new(@statement, @inttableitems)
		@update_fields.calculate
	end
end