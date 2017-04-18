class Assumption
	def initialize(statement, inttableitems)
		@statement = statement
		@inttableitems = inttableitems
	end

	# This method sets all of the interchange assumptions based on the
	#   current interchange table as it exists.  The following methods
	#   are only useful after the interchange table has been created
	#   or adjusted.
	def set_all_assumptions
		@swiped = Swiped.new(@statement, @inttableitems)
		@swiped.calculate
		
		@moto = Moto.new(@statement, @inttableitems)
		@moto.calculate

		@ecomm = Ecomm.new(@statement, @inttableitems)
		@ecomm.calculate

		@regulated_check_cards = RegulatedCheckCard.new(@statement, @inttableitems)
		@regulated_check_cards.calculate

		@unregulated_check_card = UnregulatedCheckCard.new(@statement, @inttableitems)
		@unregulated_check_card.calculate

		@credit_cards = CreditCard.new(@statement, @inttableitems)
		@credit_cards.calculate

		@vmd_cards = VmdPercent.new(@statement, @inttableitems)
		@vmd_cards.calculate

		@btob = Btob.new(@statement, @inttableitems)
		@btob.calculate

		@downgrades = Downgrade.new(@statement, @inttableitems)
		@downgrades.calculate

		@rewards = Reward.new(@statement, @inttableitems)
		@rewards.calculate

		@basic = BasicCard.new(@statement, @inttableitems)
		@basic.calculate
	end     
end