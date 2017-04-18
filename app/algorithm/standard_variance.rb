class StandardVariance
	def initialize(statement, prospect)
		@statement = statement
		@prospect = prospect
	end

	def calculate
		@merchants = Merchant.all
		@merchants.each do |merchant|
			@costs = 0
			@volume = 0
			@intitems = Intitem.where(merchant_id: merchant.id)
			@intitems.each do |item|
				@inttype = Inttype.find_by_id(item.inttype_id)
				@costs += ( (@inttype.per_item * (item.volume / 50)) + (@inttype.percent * item.volume) )
				@volume += item.volume
			end
			merchant.standard_interchange_percent = ( @costs / @volume )
			merchant.save 
		end
	end
end