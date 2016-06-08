class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
     t.references :processor, index: true, foreign_key: true
      t.string :name
      t.decimal :min_volume
      t.decimal :max_volume
      t.decimal :up_front_bonus
      t.decimal :residual_split
      t.decimal :min_bp_mark_up
      t.decimal :min_per_item_fee
      t.string :cost_structure
      t.string :terminal_type
      t.string :terminal_ownership_type
      t.decimal :per_item_cost
      t.decimal :bin_sponsorship
      t.decimal :visa_access_per_item
      t.decimal :visa_access_percentage
      t.decimal :mc_access_per_item
      t.decimal :mc_access_percentage
      t.decimal :disc_access_per_item
      t.decimal :disc_access_percentage
      t.decimal :min_monthly_fees
      t.decimal :monthly_fee_costs
      t.decimal :monthly_pci_fee
      t.decimal :monthly_pci_cost
      t.decimal :annual_pci_fee
      t.decimal :annual_pci_cost
      t.decimal :min_pin_debit_per_item_fee
      t.decimal :pin_debit_per_item_cost
      t.decimal :monthly_debit_fee_cost
      t.decimal :min_monthly_debit_fee
      t.decimal :next_day_funding_monthly_cost
      t.decimal :next_day_funding_monthly_fee
      t.decimal :amex_per_item_cost
      t.decimal :min_amex_per_item_fee
      t.decimal :amex_bp_cost
      t.decimal :min_amex_bp_fee
      t.decimal :application_fee_cost
      t.decimal :min_application_fee

      t.timestamps null: false
    end
  end
end
