class VisaMastercardDiscover
	def initialize(statement, prospect)
		@statement = statement
		@prospect = prospect
	end

	def calculate
		# Set the total Visa Mastercard Discover Volume.
		@statement.vmd_vol = @statement.total_vol - @statement.amex_vol - @statement.debit_vol

		# Set the total Visa Mastercard Discover Transactions based on the average ticket size.
		@statement.vmd_trans = @statement.vmd_vol / @statement.vmd_avg_ticket

		#Create an array of all itnerchange types from similar merchants including their effect
		#   on those merchants overall volume, average ticket and interchange costs.
		@intcalcitem_array = InterchangeAssumption.new(@statement, @prospect)
    @intcalcitems = @intcalcitem_array.calculate

  	# Create the new Interchange Table for this statement, based on
		#   the interchange table from similar business types in the database.
		@interchange_table = InterchangeTable.new(@intcalcitems, @statement)
    @inttableitems = @interchange_table.create_inttableitems

    @updated_fields = UpdateField.new(@statement, @inttableitems)
    @inttableitems = @updated_fields.calculate

    ActiveRecord::Base.transaction { @inttableitems.each(&:save) }
	end

  def update
      # Set the total Volume.
      @statement.total_vol = @statement.vmd_vol + @statement.amex_vol + @statement.debit_vol

      # Set the total Visa Mastercard Discover Average Ticket based on the volume and transactions.
      @statement.vmd_avg_ticket = @statement.vmd_vol / @statement.vmd_trans

      #Create an array of all itnerchange types from similar merchants including their effect
      #   on those merchants overall volume, average ticket and interchange costs.
      @intcalcitem_array = InterchangeAssumption.new(@statement, @prospect)
          @intcalcitems = @intcalcitem_array.calculate

      # Create the new Interchange Table for this statement, based on
      #   the interchange table from similar business types in the database.
      @interchange_table = InterchangeTable.new(@intcalcitems, @statement)
      @inttableitems = @interchange_table.create_inttableitems

      @updated_fields = UpdateField.new(@statement, @inttableitems)
      @inttableitems = @updated_fields.calculate

    end
end
  
  