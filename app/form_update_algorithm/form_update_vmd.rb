class FormUpdateVmd
	def initialize(statement, prospect)
		@statement = statement
		@prospect = prospect
	end

	def calculate
		@current_items = Inttableitem.where(statement_id: @statement.id)
		@current_items.destroy_all

		# Set the total Visa Mastercard Discover Volume based on the edit form values.
		@statement.vmd_vol = @statement.vs_volume + @statement.mc_volume + @statement.ds_volume

		# Set the total Visa Mastercard Discover Transactions based on edit form values.
		@statement.vmd_trans = @statement.vs_transactions + @statement.mc_transactions + @statement.ds_transactions

		# Set the total average ticket.
		@statement.vmd_avg_ticket = @statement.vmd_vol / @statement.vmd_trans

		#Create an array of all itnerchange types from similar merchants including their effect
		#   on those merchants overall volume, average ticket and interchange costs.
		@intcalcitem_array = FormInterchangeAssumption.new(@statement, @prospect)
	    @intcalcitems = @intcalcitem_array.calculate

	  	# Create the new Interchange Table for this statement, based on
		#   the interchange table from similar business types in the database.
		@interchange_table = FormInterchangeTable.new(@intcalcitems, @statement)
	    @inttableitems = @interchange_table.create_inttableitems

	    @updated_fields = FormUpdateField.new(@statement, @inttableitems)
	    @inttableitems = @updated_fields.calculate

	    ActiveRecord::Base.transaction { @inttableitems.each(&:save) }
	end
end