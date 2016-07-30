class CreateComparisons < ActiveRecord::Migration
  def change
    create_table :comparisons do |t|
      t.references :statement, index: true, foreign_key: true
      t.references :program, index: true, foreign_key: true
      t.decimal :batch_fees
      t.decimal :vs_mark_up_fees
      t.decimal :mc_mark_up_fees
      t.decimal :ds_mark_up_fees
      t.decimal :total_vmd_mark_up_fees
      t.decimal :amex_mark_up_fees
      t.decimal :vs_trans_fees
      t.decimal :mc_trans_fees
      t.decimal :ds_trans_fees
      t.decimal :total_vmd_trans_fees
      t.decimal :amex_trans_fees
      t.decimal :vs_access_per_item_fees
      t.decimal :mc_access_per_item_fees
      t.decimal :ds_access_per_item_fees
      t.decimal :vs_access_percentage_fees
      t.decimal :mc_access_percentage_fees
      t.decimal :ds_access_percentage_fees
      t.decimal :total_vmd_access_fees
      t.decimal :debit_trans_fees
      t.decimal :total_debit_fees
      t.decimal :total_program_fees
      t.decimal :batch_fee_costs
      t.decimal :bin_fee_costs
      t.decimal :vs_trans_fee_costs
      t.decimal :mc_trans_fee_costs
      t.decimal :ds_trans_fee_costs
      t.decimal :total_vmd_trans_fee_costs
      t.decimal :amex_per_item_costs
      t.decimal :amex_mark_up_costs
      t.decimal :debit_per_item_costs
      t.decimal :total_debit_costs
      t.decimal :total_program_costs
      t.decimal :total_program_savings
      t.decimal :total_program_residuals
      t.decimal :total_program_bonus
      t.timestamps null: false
    end
  end
end
