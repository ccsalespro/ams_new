class FormInterchangeAssumption
	def initialize(statement, prospect)
		@statement = statement
		@prospect = prospect
    	@description_id = @prospect.description_id

		# Find all merchants in the database maching the primary description.
		@merchants_by_type = Merchant.all.where(["description_id = ?", @description_id])
	end

	def calculate  
		@vs_transactions = 0
		@vs_volume = 0
		@mc_transactions = 0
		@mc_volume = 0
		@ds_transactions = 0
		@ds_volume = 0
		@number_of_merchants = 0
		@intcalcitems = []

		# Iterate through each merchant matching the business type of the prospect
		@merchants_by_type.each do |merchant|

			# Add up the total number of merchants matching the business type of the prospect
			@number_of_merchants += 1

			# Create array of all interchange items from a merchant statement in database.  
			@merchantintitems = merchant.intitems

			@merchantintitems.each do |item|
				# Set the card brand for this merchant interchange item.
				@brand = item.inttype.card_type
			 
				# Add up the total number of transactions and volume by brand for all merchants combined.
				if @brand == "VS"
					@vs_transactions += item.transactions
					@vs_volume += item.volume
				elsif @brand == "MC"
					@mc_transactions += item.transactions
					@mc_volume += item.volume
				elsif @brand == "DS"
					@ds_transactions += item.transactions
					@ds_volume += item.volume
				end

				# Does the @intcalcitems array already have an item with the same interchange type as this one?
				if @intcalcitems.any? {|i| i.inttype_id == item.inttype_id}

				  # If so, find the intcalcitem related to the same interchange type as this one.
				  @intcalcitem = @intcalcitems.find {|i| i.inttype_id == item.inttype_id}

				  # Now add the transactions and volume for this interchange item to this interchange type.
				  @intcalcitem.transactions += item.transactions
				  @intcalcitem.volume += item.volume

				else

				  # If this interchange type does not exist yet in the array, create a new item.
				  @intcalcitem = InterchangeTypeItem.new
				  @intcalcitem.prospect_id = @prospect.id
				  @intcalcitem.inttype_id = item.inttype_id
				  @intcalcitem.transactions = item.transactions
				  @intcalcitem.volume = item.volume
				  @intcalcitem.description_id = @prospect.description_id
				  @intcalcitem.card_type = @brand

				  # Add this new interchange type to the intcalcitems array.
				  @intcalcitems << @intcalcitem
				end
			end
		end

		@intcalcitems.each do |item| 
			if item.card_type == "VS"
		      # What percentage of the total volume from all related merchants does each interchange type make up?
		      item.inttype_percent = item.volume.to_f / @vs_volume.to_f

		      # What is the average ticket across all merchants in our database of this business type?
		      @total_avg_ticket = @vs_volume.to_f / @vs_transactions.to_f

		      # What is the average ticket size for this specific interchange type for these same merchants?
		      @intcalc_avg_ticket = item.volume.to_f / item.transactions.to_f
		      
		      # What is the percentage difference for the avg ticket for this specific interchange type?
		      item.avg_ticket_variance = @intcalc_avg_ticket / @total_avg_ticket

		  	elsif item.card_type == "MC"
		      # What percentage of the total volume from all related merchants does each interchange type make up?
		      item.inttype_percent = item.volume.to_f / @mc_volume.to_f

		      # What is the average ticket across all merchants in our database of this business type?
		      @total_avg_ticket = @mc_volume.to_f / @mc_transactions.to_f

		      # What is the average ticket size for this specific interchange type for these same merchants?
		      @intcalc_avg_ticket = item.volume.to_f / item.transactions.to_f
		      
		      # What is the percentage difference for the avg ticket for this specific interchange type?
		      item.avg_ticket_variance = @intcalc_avg_ticket / @total_avg_ticket

		    elsif item.card_type == "DS"
		      # What percentage of the total volume from all related merchants does each interchange type make up?
		      item.inttype_percent = item.volume.to_f / @ds_volume.to_f

		      # What is the average ticket across all merchants in our database of this business type?
		      @total_avg_ticket = @ds_volume.to_f / @ds_transactions.to_f

		      # What is the average ticket size for this specific interchange type for these same merchants?
		      @intcalc_avg_ticket = item.volume.to_f / item.transactions.to_f
		      
		      # What is the percentage difference for the avg ticket for this specific interchange type?
		      item.avg_ticket_variance = @intcalc_avg_ticket / @total_avg_ticket
		    end
		end
		return @intcalcitems
	end
end