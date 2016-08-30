class ComparisonPdf < Prawn::Document

	def initialize(prospect, statement, comparison)
		super(top_margin: 70)
		@prospect = prospect
		@statement = statement
		@comparison = comparison
		prospect_name
		card_type_summary
	end

	def prospect_name
		text "#{@prospect.business_name} Proposal", size: 30, style: :bold
	end

	def card_types
		move_down 20
		table card_type_rows
	end

	def card_type_rows
		[["Type", "Volume", "Items", "Fees"]] + 
		@comparison.card_types.map do |type|
			[]
		end
	end

end