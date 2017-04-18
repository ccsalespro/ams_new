class InterchangeCost
	def initialize(inttableitems)
		@inttableitems = inttableitems
	end
	
	def calculate_cost
      @costs = 0
      @inttableitems.each do |item|
        @costs += item.costs
      end
      @costs
    end
end