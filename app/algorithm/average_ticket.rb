class AverageTicket
	def initialize(statement)
		@statement = statement
	end

	def calculate
		calculate_vmd_avg_ticket
		set_vmd_avg_ticket
	end

	# Set all average tickets to the average ticket entered in the statement form.
	# This is not accurate and needs to be adjusted since Pin Debit transactions are
	#    more likely to be lower than the average while AMEX is likely to be higher.
	def calculate_vmd_avg_ticket
		if @statement.amex_vol <= 0
			@amex_transactions = 0
		else
			@amex_transactions = @statement.amex_vol / @statement.amex_avg_ticket
		end

		if @statement.debit_vol <= 0
			@debit_transactions = 0 
		else
			@debit_avg_ticket = @statement.debit_avg_ticket
			@debit_transactions = @statement.debit_vol / @statement.debit_avg_ticket
		end

		@vmd_vol = @statement.total_vol - @statement.amex_vol - @statement.debit_vol
		@total_transactions = @statement.total_vol / @statement.avg_ticket
		@vmd_transactions = @total_transactions - @amex_transactions - @debit_transactions
		@statement.vmd_avg_ticket = @vmd_vol / @vmd_transactions
	end

	def set_vmd_avg_ticket
		@statement.vs_avg_ticket = @statement.vmd_avg_ticket
		@statement.mc_avg_ticket = @statement.vmd_avg_ticket
		@statement.ds_avg_ticket = @statement.vmd_avg_ticket
	end
    
end