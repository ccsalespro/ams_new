class PinDebit
	def initialize(statement)
		@statement = statement
	end

	def set_zero_values
		@statement.debit_vol = 0
		@statement.debit_trans = 0
		@statement.debit_network_fees = 0
		@statement.debit_avg_ticket = 0
	end

	def set_debit_avg_ticket
		if @statement.debit_vol > 0
			@statement.debit_avg_ticket = (@statement.avg_ticket * 0.8)
			if @statement.debit_vol < @statement.debit_avg_ticket
				@statement.debit_avg_ticket = @statement.debit_vol
			end
		else
			@statement.debit_avg_ticket = 0
		end
	end

	def calculate
		# If Pin Debit Volume is 0, set Pin Debit Fields to 0 rather than nil for later calculations
		if @statement.debit_vol == nil || @statement.debit_vol == 0
			set_zero_values
		else
			set_debit_avg_ticket
			# Set up total number of debit transactions based on the average ticket and volume.
			@statement.debit_trans = @statement.debit_vol / @statement.debit_avg_ticket

			# Find the per item and percentage cost from the cost table for pin debit.
			debit_cost("debit", @statement.avg_ticket)

			# Calculate the total debit network fees based on the cost.
			@statement.debit_network_fees = ((@statement.debit_trans * @cost.per_item_value) + (@statement.debit_vol * (@cost.percentage_value/100)))
		end
	end

	def debit_cost(payment_type, avg_ticket)
      @cost = Cost.where(["payment_type = ?", "#{payment_type}"]).where(["low_ticket <= ?", "#{avg_ticket}"]).where(["high_ticket >= ?", "#{avg_ticket}"]).first
    end

    def update
		# If Pin Debit Volume is 0, set Pin Debit Fields to 0 rather than nil for later calculations
		if @statement.debit_vol == nil || @statement.debit_vol == 0
			set_zero_values
		else
			# Set up total number of debit transactions based on the average ticket and volume.
			@statement.debit_avg_ticket = @statement.debit_vol / @statement.debit_trans

			# Find the per item and percentage cost from the cost table for pin debit.
			debit_cost("debit", @statement.debit_avg_ticket)

			# Calculate the total debit network fees based on the cost.
			@statement.debit_network_fees = ((@statement.debit_trans * @cost.per_item_value) + (@statement.debit_vol * (@cost.percentage_value/100)))
		end
	end
end