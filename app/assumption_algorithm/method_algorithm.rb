class MethodAlgorithm < AssumptionAlgorithm
	def calculate
		@inttableitems = Inttableitem.where(statement_id: @statement.id)

		@swiped_volume_change = (((@statement.swiped_percent / 100) * @statement.vmd_vol) - @statement.swiped_vol)
		@swiped_percent_change = (@swiped_volume_change / @statement.swiped_vol)
		@vs_swiped_volume_change = @swiped_volume_change * ((@statement.vs_moto_percentage + @statement.vs_swiped_percentage) / 2)
		@mc_swiped_volume_change = @swiped_volume_change * ((@statement.mc_moto_percentage + @statement.mc_swiped_percentage) / 2)
		@ds_swiped_volume_change = @swiped_volume_change * ((@statement.ds_moto_percentage + @statement.ds_swiped_percentage) / 2)
		@vs_swiped_percent_change = @vs_swiped_volume_change / @statement.vs_swiped_volume
		@mc_swiped_percent_change = @mc_swiped_volume_change / @statement.mc_swiped_volume
		@ds_swiped_percent_change = @ds_swiped_volume_change / @statement.ds_swiped_volume


		@keyed_volume_change = (((@statement.moto_percentage / 100) * @statement.vmd_vol) - @statement.moto_vol)
		@keyed_percent_change = (@keyed_volume_change / @statement.moto_vol)
		@vs_moto_volume_change = @keyed_volume_change * ((@statement.vs_moto_percentage + @statement.vs_swiped_percentage) / 2)
		@mc_moto_volume_change = @keyed_volume_change * ((@statement.mc_moto_percentage + @statement.mc_swiped_percentage) / 2)
		@ds_moto_volume_change = @keyed_volume_change * ((@statement.ds_moto_percentage + @statement.ds_swiped_percentage) / 2)
		@vs_moto_percent_change = @vs_moto_volume_change / @statement.vs_moto_volume
		@mc_moto_percent_change = @mc_moto_volume_change / @statement.mc_moto_volume
		@ds_moto_percent_change = @ds_moto_volume_change / @statement.ds_moto_volume
		

		@inttableitems.each do |item|
			@inttype = Inttype.find_by_id(item.inttype_id)
			if @inttype.keyed == true || @inttype.ecomm == true
				if @inttype.card_type == "VS"
					item.volume = item.volume + (item.volume * @vs_moto_percent_change)
				elsif @inttype.card_type == "MC"
					item.volume = item.volume + (item.volume * @mc_moto_percent_change)
				elsif @inttype.card_type == "DS"
					item.volume = item.volume + (item.volume * @ds_moto_percent_change)
				end
			else
				if @inttype.card_type == "VS"
					item.volume = item.volume + (item.volume * @vs_swiped_percent_change)
				elsif @inttype.card_type == "MC"
					item.volume = item.volume + (item.volume * @mc_swiped_percent_change)
				elsif @inttype.card_type == "DS"
					item.volume = item.volume + (item.volume * @ds_swiped_percent_change)
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