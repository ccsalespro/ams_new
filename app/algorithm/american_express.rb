class AmericanExpress
	def initialize(statement, prospect)
		@statement = statement
		@prospect = prospect
	end

	def set_zero_values
		# If AMEX Volume is 0, set AMEX fields to zero
			@statement.amex_vol = 0
			@statement.amex_trans = 0
			@statement.amex_interchange = 0
			@statement.amex_per_item_cost = 0
			@statement.amex_percentage_cost = 0
			@statement.amex_avg_ticket = 0
	end

	def set_amex_avg_ticket
		if @statement.amex_vol > 0
			@statement.amex_avg_ticket = @statement.avg_ticket + (@statement.avg_ticket * 0.5)
			if @statement.amex_vol < @statement.amex_avg_ticket
				@statement.amex_avg_ticket = @statement.amex_vol
			end
		else
			@statement.amex_avg_ticket = 0
		end
	end

	def calculate
		if @statement.amex_vol == nil || @statement.amex_vol == 0
			set_zero_values
		else
			set_amex_avg_ticket
			# Set number of AMEX transactions
			@statement.amex_trans = @statement.amex_vol / @statement.amex_avg_ticket

			# Find AMEX Opt Blue Cost
			amex_cost("amex", @prospect.amex_business_type, @statement.avg_ticket)

			# Set AMEX total Opt Blue Cost
			@statement.amex_interchange = ((@statement.amex_trans * @cost.per_item_value) + (@statement.amex_vol * (@cost.percentage_value/100)))
			
			# Set AMEX Opt Blue Per Item Cost
			@statement.amex_per_item_cost = @cost.per_item_value

			# Set AMEX Opt Blue Percentage Cost
			@statement.amex_percentage_cost = @cost.percentage_value
		end
	end

    def update
    	if @statement.amex_vol == nil || @statement.amex_vol == 0
			set_zero_values
		else
	    	# Set AMEX Average Ticket from the new volume and number of transactions
			@statement.amex_avg_ticket = @statement.amex_vol / @statement.amex_trans

			# Find AMEX Opt Blue Cost
			amex_cost("amex", @prospect.amex_business_type, @statement.amex_avg_ticket)

			# Set AMEX total Opt Blue Cost
			@statement.amex_interchange = ((@statement.amex_trans * @cost.per_item_value) + (@statement.amex_vol * (@cost.percentage_value/100)))
			
			# Set AMEX Opt Blue Per Item Cost
			@statement.amex_per_item_cost = @cost.per_item_value

			# Set AMEX Opt Blue Percentage Cost
			@statement.amex_percentage_cost = @cost.percentage_value
		end
    end

    def amex_cost(payment_type, business_type, avg_ticket)
      @cost = Cost.where(["business_type = ?", "#{business_type}"]).where(["payment_type = ?", "#{payment_type}"]).where(["low_ticket <= ?", "#{avg_ticket}"]).where(["high_ticket >= ?", "#{avg_ticket}"]).first
    end
end