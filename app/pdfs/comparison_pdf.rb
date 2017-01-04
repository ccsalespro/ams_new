class ComparisonPdf < Prawn::Document

	def initialize(prospect, statement, comparison, view, user)
		super(top_margin: 70)
		@prospect = prospect
		@statement = statement
		@comparison = comparison
		@view = view
		@user = user
		prospect_name
		user_labels
		card_types
		savings_amounts
	end

	def prospect_name
		text "Proposal Detail: #{@prospect.business_name}", size: 20, style: :bold, align: :center
	end
	
	def user_labels
		move_down 0
		text "Contact: #{@user.first_name} #{@user.last_name}  |  Phone: #{@user.phone_number}  |  Email: #{@user.email}", size: 9, style: :bold, align: :center
	end

	def card_types
		move_down 20
		table card_type_rows do
			row(0..6).border_width = 0.3
			row(0).font_style = :bold
			row(-1).font_style = :bold
			columns(0..3).align = :left
			row(0).align = :center
			columns(0).width = 75
			columns(1..3).width = 125
			self.row_colors = ["f2f2f2", "FFFFFF"]
			self.header = true
			self.row(0).background_color = '03af52'
			self.row(0).text_color = 'FFFFFF'
			self.position = :center
		end
	end

	def card_type_rows
		total_vs_fees
		total_mc_fees
		total_ds_fees
		total_amex_fees
		total_debit_fees
		total_transactions

		if @statement.amex_vol == 0 && @statement.debit_vol == 0
			card_type_header + 
			card_type_vmd_rows +
			card_type_totals
		elsif @statement.amex_vol > 0 && @statement.debit_vol == 0
			card_type_header + 
			card_type_vmd_rows +
			card_type_amex_row +
			card_type_totals
		elsif @statement.amex_vol == 0 && @statement.debit_vol > 0
			card_type_header + 
			card_type_vmd_rows +
			card_type_debit_row +
			card_type_totals
		else
			card_type_header + 
			card_type_vmd_rows +
			card_type_amex_row +
			card_type_debit_row +
			card_type_totals
		end
	end

	def card_type_header
		[["Type", "Volume", "Items", "Fees"]]
	end

	def card_type_vmd_rows
		[["VS", to_currency(@statement.vs_volume), to_integer(@statement.vs_transactions), to_currency(@total_visa_fees)],
		["MC", to_currency(@statement.mc_volume), to_integer(@statement.mc_transactions), to_currency(@total_mc_fees)],
		["DS", to_currency(@statement.ds_volume), to_integer(@statement.ds_transactions), to_currency(@total_ds_fees)]]
	end

	def card_type_totals
		[["Totals", to_currency(@statement.total_vol), to_integer(@transactions), to_currency(@comparison.total_program_fees)]]
	end

	def card_type_debit_row
		[["Debit", to_currency(@statement.debit_vol), to_integer(@statement.debit_trans), to_currency(@total_debit_fees)]]
	end

	def card_type_amex_row
		[["Amex", to_currency(@statement.amex_vol), to_integer(@statement.amex_trans), to_currency(@total_amex_fees)]]
	end

	def savings_amounts
		move_down 20
		table savings_row do
			row(0..1).border_width = 0.3
			row(0).font_style = :bold
			row(1).font_style = :bold
			columns(0..1).align = :left
			row(0).align = :center
			columns(0..3).width = 150
			self.header = true
			self.row(0).background_color = '03af52'
			self.row(0).text_color = 'FFFFFF'
			self.position = :center

		end
	end

	def savings_row
		[["Monthly Savings", "Annual Savings", "3 Year Savings"], 
		[to_currency(@comparison.total_program_savings), to_currency(@comparison.total_program_savings * 12), to_currency(@comparison.total_program_savings * 36)]]

	end

	def interchange
		move_down 20
		table interchange_items
	end

	def interchange_items
		@interchange_items = Inttableitems.where(statement_id: @statement.id)
		[["Description", "Volume", "Savings"]]
	end

	def to_currency(var)
		@view.number_to_currency(var)
	end

	def to_integer(var)
		@view.number_with_precision(var, precision: 0)
	end

    def total_transactions
    	@transactions = @statement.vs_transactions + @statement.mc_transactions + @statement.ds_transactions + @statement.amex_trans + @statement.debit_trans
    end

	def total_vs_fees
		@vs_access_fees = (@comparison.vs_access_per_item_fees) + (@comparison.vs_access_percentage_fees)
  		@total_visa_fees = (@statement.vs_fees + @comparison.vs_trans_fees + @vs_access_fees + @comparison.vs_mark_up_fees)
	end

	def total_mc_fees
		@mc_access_fees = (@comparison.mc_access_per_item_fees) + (@comparison.mc_access_percentage_fees)
  		@total_mc_fees = (@statement.mc_fees + @comparison.mc_trans_fees + @mc_access_fees + @comparison.mc_mark_up_fees)
	end

	def total_ds_fees
		@ds_access_fees = (@comparison.ds_access_per_item_fees) + (@comparison.ds_access_percentage_fees)
  		@total_ds_fees = (@statement.ds_fees + @comparison.ds_trans_fees + @ds_access_fees + @comparison.ds_mark_up_fees)
	end

	def total_amex_fees
		@amex_mark_up = ( @statement.amex_vol * (@comparison.amex_bp_mark_up.to_f / 10000 ) )
		@total_amex_fees = (@statement.amex_interchange + (@statement.amex_trans * @comparison.amex_per_item_fee) + @amex_mark_up)
	end

	def total_debit_fees
		@total_debit_fees = (@statement.debit_network_fees + (@statement.debit_trans * @comparison.pin_debit_per_item_fee))
	end
end

 