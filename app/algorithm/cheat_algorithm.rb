class CheatAlgorithm
	def initialize(statement)
		@statement = statement
	end

	def calculate
		@vs_int_percent = @statement.vs_fees / @statement.form_vmd_interchange
		@mc_int_percent = @statement.mc_fees / @statement.form_vmd_interchange 
		@ds_int_percent = @statement.ds_fees / @statement.form_vmd_interchange

		@statement.vs_fees = @statement.vmd_interchange * @vs_int_percent
		@statement.mc_fees = @statement.vmd_interchange * @mc_int_percent
		@statement.ds_fees = @statement.vmd_interchange * @ds_int_percent

		# Set the total cost pass through for VMD, AMEX and Pin Debit.
		@statement.vmd_interchange = @statement.vs_fees + @statement.mc_fees + @statement.ds_fees
		@statement.form_vmd_interchange = @statement.vmd_interchange
    	@statement.interchange = @statement.vmd_interchange + @statement.amex_interchange + @statement.debit_network_fees
    	
		@statement.save  
	end
end