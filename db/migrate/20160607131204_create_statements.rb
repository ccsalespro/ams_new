class CreateStatements < ActiveRecord::Migration
  def change
    create_table :statements do |t|
     
      t.decimal :total_fees		
	  t.integer :batches		
	  t.integer :amex_trans		
	  t.decimal :amex_vol			
	  t.integer :vmd_trans		
	  t.decimal :vmd_vol			
	  t.integer :debit_trans		
	  t.decimal :debit_vol	
	  t.decimal :interchange
	  t.string  :statement_month
	  t.decimal :avg_ticket
      t.decimal :vmd_avg_ticket
      t.decimal :amex_avg_ticket
      t.decimal :debit_avg_ticket
      t.decimal :check_card_avg_ticket
      t.decimal :check_card_trans
      t.decimal :check_card_vol
      t.decimal :debit_network_fees
      t.decimal :check_card_interchange
      t.decimal :amex_interchange
      t.decimal :vmd_interchange
      t.decimal :total_vol
      t.string  :business_type
      t.belongs_to :prospect

      t.timestamps null: false
    end
  end
end
