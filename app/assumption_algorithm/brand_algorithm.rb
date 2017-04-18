class BrandAlgorithm < AssumptionAlgorithm
	def calculate
		@inttableitems = Inttableitem.where(statement_id: @statement.id)

		@vs_volume_change = (((@statement.vs_percent / 100) * @statement.vmd_vol) - @statement.vs_volume)
		@vs_percent_change = (@vs_volume_change / @statement.vs_volume)

		@mc_volume_change = (((@statement.mc_percent / 100) * @statement.vmd_vol) - @statement.mc_volume)
		@mc_percent_change = (@mc_volume_change / @statement.mc_volume)

		@ds_volume_change = (((@statement.ds_percent / 100) * @statement.vmd_vol) - @statement.ds_volume)
		@ds_percent_change = (@ds_volume_change / @statement.ds_volume)
		

		@inttableitems.each do |item|
			@inttype = Inttype.find_by_id(item.inttype_id)
			if @inttype.card_type == "VS"
				item.volume = item.volume + (item.volume * @vs_percent_change)
			elsif @inttype.card_type == "MC"
				item.volume = item.volume + (item.volume * @mc_percent_change)
			elsif @inttype.card_type == "DS"
				item.volume = item.volume + (item.volume * @ds_percent_change)
			end
			 # Set the total number of transactions for this interchange type based on avg ticket.
	        item.transactions = item.volume / item.avg_ticket

	        # Set total interchange cost for this interchange type.
	        item.costs = ( item.transactions * @inttype.per_item ) + ( item.volume.to_f * @inttype.percent )
			item.save
		end
		@update_fields = UpdateField.new(@statement, @inttableitems)
		@update_fields.calculate

		@assumptions = Assumption.new(@statement, @inttableitems)
		@assumptions.set_all_assumptions
	end
end