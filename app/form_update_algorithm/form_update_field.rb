class FormUpdateField
	def initialize(statement, inttableitems)	
		@statement = statement
		@inttableitems = inttableitems
	end

	def calculate
	  	# Set the total interchange costs for Visa, Mastercard and Discover combined.
	  	@interchange_cost = InterchangeCost.new(@inttableitems)
	  	@statement.vmd_interchange = @interchange_cost.calculate_cost

	  	# Create an array @records for the total volume and interchange fees for Visa Transactions.
	  	@records = card_type_calculation("VS")

	  	# Set the total Visa Volume from the interchange types.
	    @statement.vs_volume = @records[0]

	    # Set the total number of Visa Transactions based on the total volume and averge ticket.
	    @statement.vs_transactions = @records[0] / @statement.vs_avg_ticket

	    # Set the total visa interchange (vs_fees)
	    @statement.vs_fees = @records[1]

	    # Create an array @records for the total volume and interchange fees for Mastercard.
	    @records = card_type_calculation("MC")
	    @statement.mc_volume = @records[0]
	    @statement.mc_transactions = @records[0] / @statement.mc_avg_ticket
	    @statement.mc_fees = @records[1]

	    # Create an array @records for the total volume and interchange fees for Discover.
	    @records = card_type_calculation("DS")
	    @statement.ds_volume = @records[0]
	    @statement.ds_transactions = @records[0] / @statement.ds_avg_ticket
	    @statement.ds_fees = @records[1]

	  	# Set the Interchange Assumption fields based on the existing data / similar business types.
		@interchange_assumption = Assumption.new(@statement, @inttableitems)
		@interchange_assumption.set_all_assumptions
	    return @inttableitems
	end

	def card_type_calculation(card_type_var)
    @volume = 0
    @fees = 0
    @inttableitems.each do |item|
      @inttype = Inttype.find_by_id(item.inttype_id)
      if @inttype.card_type == card_type_var 
        @volume += item.volume
        @fees += item.costs
      end
    end
    @records = [@volume, @fees]
    return @records  
  end

end