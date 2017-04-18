class FormUpdateAlgorithm
	def initialize(statement, prospect)
		@prospect = prospect
		@statement = statement
	end

	def calculate
		# Set Up Visa, Mastercard Discover if Volume is higher than 0
	    @vmd = FormUpdateVmd.new(@statement, @prospect)
	    @inttableitems = @vmd.calculate
	    
    return @inttableitems
	end
end