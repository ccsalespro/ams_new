class InterchangeTable
	def initialize(intcalcitems, statement)
		@intcalcitems = intcalcitems
		@statement = statement
    end

    def create_inttableitems
      @inttableitems = []
		
		# Iterate through all the interchange types for this business type.
		@intcalcitems.each do |item|

			# Find the interchange type for this item.
	        @inttype = Inttype.find_by_id(item.inttype_id) 

	        # Create a new item on the interchange table for this interchange type.  
	        @inttableitem = Inttableitem.new
	        @inttableitem.statement_id = @statement.id
	        @inttableitem.inttype_id = item.inttype_id
	        @inttableitem.inttype_description = @inttype.description
	        @inttableitem.inttype_percent = @inttype.percent
	        @inttableitem.inttype_per_item = @inttype.per_item

	        # Set the volume based on the percentage of volume this interchange 
	        #   type had for all the similar merchants in the data set.
	        @inttableitem.volume = @statement.vmd_vol * item.inttype_percent

	        # Set the average ticket for this interchange type based on the same
	        #   interchange type average ticket variance calculated earlier.
	        @inttableitem.avg_ticket = @statement.vmd_avg_ticket * item.avg_ticket_variance

	        # Set the total number of transactions for this interchange type based on avg ticket.
	        @inttableitem.transactions = @inttableitem.volume / @inttableitem.avg_ticket

	        # Set total interchange cost for this interchange type.
	        @inttableitem.costs = ( @inttableitem.transactions * @inttype.per_item ) + ( @inttableitem.volume.to_f * @inttype.percent )
	        
	        # Add this interchange type to the interchange table array.
	        @inttableitems << @inttableitem
      	end
      	@inttableitems = @inttableitems.sort! {|x, y| y.volume <=> x.volume}
      	return @inttableitems
    end
end