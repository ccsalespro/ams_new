class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.string :business_dba
      t.integer :data_number
      t.string :business_type_primary
      t.string :business_type_secondary
      t.integer :sic_1
      t.integer :sic_2
      t.integer :sic_3
      t.decimal :interchange_percentage
      t.decimal :avg_ticket
      t.decimal :amex_percentage
      t.decimal :amex_per_item
      t.decimal :check_card_percentage
      t.decimal :amex_vol
      t.decimal :check_card_vol
      t.decimal :mc_vol
      t.decimal :vs_vol
      t.decimal :disc_vol
      t.decimal :debit_vol
      t.integer :total_transactions
      t.integer :amex_transactions
      t.decimal :interchange_fees
      t.decimal :total_fees
      t.integer :debit_transactions
      t.decimal :debit_network_fees
      t.decimal :ebt_vol
      t.decimal :ebt_fees

      t.timestamps null: false
    end
  end
end
