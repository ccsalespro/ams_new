class CheckCardAlgorithm < AssumptionAlgorithm
	def calculate
		@inttableitems = Inttableitem.where(statement_id: @statement.id)

		@vs_avg_percent = ((@statement.vs_check_card_percentage + @statement.vs_unreg_debit_percentage + @statement.vs_credit_percentage) / 3)
		@mc_avg_percent = ((@statement.mc_check_card_percentage + @statement.mc_unreg_debit_percentage + @statement.mc_credit_percentage) / 3)
		@ds_avg_percent = ((@statement.ds_check_card_percentage + @statement.ds_unreg_debit_percentage + @statement.ds_credit_percentage) / 3)

		@reg_volume_change = (((@statement.check_card_percentage / 100) * @statement.vmd_vol) - @statement.check_card_vol)
		@reg_percent_change = (@reg_volume_change / @statement.check_card_vol)
		@vs_reg_volume_change = @reg_volume_change * @vs_avg_percent 
		@mc_reg_volume_change = @reg_volume_change * @mc_avg_percent
		@ds_reg_volume_change = @reg_volume_change * @ds_avg_percent
		@vs_reg_percent_change = @vs_reg_volume_change / @statement.vs_check_card_volume
		@mc_reg_percent_change = @mc_reg_volume_change / @statement.mc_check_card_volume
		@ds_reg_percent_change = @ds_reg_volume_change / @statement.ds_check_card_volume

		@unreg_volume_change = (((@statement.unreg_debit_percentage / 100) * @statement.vmd_vol) - @statement.unreg_debit_vol)
		@unreg_percent_change = (@unreg_volume_change / @statement.unreg_debit_vol)
		@vs_unreg_volume_change = @unreg_volume_change * @vs_avg_percent
		@mc_unreg_volume_change = @unreg_volume_change * @mc_avg_percent
		@ds_unreg_volume_change = @unreg_volume_change * @ds_avg_percent
		@vs_unreg_percent_change = @vs_unreg_volume_change / @statement.vs_unreg_debit_volume
		@mc_unreg_percent_change = @mc_unreg_volume_change / @statement.mc_unreg_debit_volume
		@ds_unreg_percent_change = @ds_unreg_volume_change / @statement.ds_unreg_debit_volume

		@credit_volume_change = (((@statement.credit_percent / 100) * @statement.vmd_vol) - @statement.credit_volume)
		@credit_percent_change = (@credit_volume_change / @statement.credit_volume)
		@vs_credit_volume_change = @credit_volume_change * @vs_avg_percent
		@mc_credit_volume_change = @credit_volume_change * @mc_avg_percent
		@ds_credit_volume_change = @credit_volume_change * @ds_avg_percent
		@vs_credit_percent_change = @vs_credit_volume_change / @statement.vs_credit_volume
		@mc_credit_percent_change = @mc_credit_volume_change / @statement.mc_credit_volume
		@ds_credit_percent_change = @ds_credit_volume_change / @statement.ds_credit_volume
		

		@inttableitems.each do |item|
			@inttype = Inttype.find_by_id(item.inttype_id)
			if @inttype.regulated == true && @inttype.debit == true
				if @inttype.card_type == "VS"
					item.volume = item.volume + (item.volume * @vs_reg_percent_change)
				elsif @inttype.card_type == "MC"
					item.volume = item.volume + (item.volume * @mc_reg_percent_change)
				elsif @inttype.card_type == "DS"
					item.volume = item.volume + (item.volume * @ds_reg_percent_change)
				end
			elsif @inttype.debit == true && @inttype.regulated == false
				if @inttype.card_type == "VS"
					item.volume = item.volume + (item.volume * @vs_unreg_percent_change)
				elsif @inttype.card_type == "MC"
					item.volume = item.volume + (item.volume * @mc_unreg_percent_change)
				elsif @inttype.card_type == "DS"
					item.volume = item.volume + (item.volume * @ds_unreg_percent_change)
				end
			else
				if @inttype.card_type == "VS"
					item.volume = item.volume + (item.volume * @vs_credit_percent_change)
				elsif @inttype.card_type == "MC"
					item.volume = item.volume + (item.volume * @mc_credit_percent_change)
				elsif @inttype.card_type == "DS"
					item.volume = item.volume + (item.volume * @ds_credit_percent_change)
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