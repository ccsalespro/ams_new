# We start by creating the intcalcitems
# We use these to set the initial assumption array.
# We make a way to submit a new set of assumptions
# We use the assumption array to create a new intcalcitems array.
# We use the intcalcitem array to create inttableitems array.

class InterchangeAlgorithm
	def initialize(statement, prospect, category_array)
		@statement = statement
		@prospect = prospect
		@category_array = category_array

		@total_items_vol = 0

		@swiped_volume = 0
		@keyed_volume = 0
		@ecomm_volume = 0

		@vs_volume = 0		
		@mc_volume = 0		
		@ds_volume = 0

		@reg_volume = 0 
		@unreg_volume = 0
		@credit_volume = 0

		@business_volume = 0
		@downgrade_volume = 0
		@rewards_volume = 0
		@basic_volume = 0
	end

	#  "check_card_percentage"
   #  "unreg_debit_percentage"
   #  "btob_percentage"
   #  "downgrade_percentage"
   #  "moto_percentage"
   #  "ecomm_percentage"
   #  "swiped_percent"
   #  "vs_percent"
   #  "mc_percent"
   #  "ds_percent"
   #  "credit_percent"
   #  "rewards_percent"
   #  "basic_percent"

	def set_default_assumptions
		@category_array[0][0].each do |item|
			@swiped_volume += item.volume
		end

		@category_array[0][1].each do |item|
			@keyed_volume += item.volume 
		end

		@category_array[0][2].each do |item|
			@ecomm_volume += item.volume 
		end

		@category_array[1][0].each do |item|
			@vs_volume += item.volume
		end

		@category_array[1][1].each do |item|
			@mc_volume += item.volume
		end

		@category_array[1][2].each do |item|
			@ds_volume += item.volume
		end

		@category_array[2][0].each do |item|
			@reg_volume += item.volume
		end

		@category_array[2][1].each do |item|
			@unreg_volume += item.volume
		end

		@category_array[2][2].each do |item|
			@credit_volume += item.volume
		end

		@category_array[3][0].each do |item|
			@basic_volume += item.volume
		end

		@category_array[3][1].each do |item|
			@rewards_volume += item.volume
		end

		@category_array[3][2].each do |item|
			@downgrade_volume += item.volume
		end

		@category_array[3][3].each do |item|
			@business_volume += item.volume
		end

		@total_items_vol = @vs_volume + @mc_volume + @ds_volume

		# Set the percentages based on the new volume numbers.
		@swiped_percent = @swiped_volume / @total_items_vol
		@keyed_percent = @keyed_volume / @total_items_vol
		@ecomm_percent = @ecomm_volume / @total_items_vol

		@vs_percent = @vs_volume / @total_items_vol
		@mc_percent = @mc_volume / @total_items_vol
		@ds_percent = @ds_volume / @total_items_vol

		@reg_percent = @reg_volume / @total_items_vol
		@unreg_percent = @unreg_volume / @total_items_vol
		@credit_percent = @credit_percent / @total_items_vol

		@business_percent = @business_volume / @total_items_vol
		@downgrade_percent = @downgrade_volume / @total_items_vol
		@rewards_percent = @rewards_volume / @total_items_vol
		@basic_percent = @basic_volume / @total_items_vol
	end

	def calculate
		# Set the assumptions based on the default intcalcitems from the business type matches.
		set_default_assumptions

		# Check the swiped percentage to see if it does not match the default for this business type
		if @statement.swiped_percent.round(1) != @swiped_percent.round(1)
			@change = @statement.swiped_percent - @swiped_percent
			@statement.swiped_volume = @swiped_percent
			if @keyed_percent.round(1) == @statement.moto_percentage.round(1)
				@statement.moto_percentage += @change
			else
			end
		end
	end
end