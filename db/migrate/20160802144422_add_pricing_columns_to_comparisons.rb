class AddPricingColumnsToComparisons < ActiveRecord::Migration
  def change
    add_column :comparisons, :bp_mark_up, :integer
    add_column :comparisons, :per_item_fee, :decimal
    add_column :comparisons, :vs_access_per_item_fee, :decimal
    add_column :comparisons, :vs_access_percentage_fee, :decimal
    add_column :comparisons, :mc_access_per_item_fee, :decimal
    add_column :comparisons, :mc_access_percentage_fee, :decimal
    add_column :comparisons, :ds_access_per_item_fee, :decimal
    add_column :comparisons, :ds_access_percentage_fee, :decimal
    add_column :comparisons, :monthly_pci_fee, :decimal
    add_column :comparisons, :annual_pci_fee, :decimal
    add_column :comparisons, :pin_debit_per_item_fee, :decimal
    add_column :comparisons, :pin_debit_bp_mark_up, :integer
    add_column :comparisons, :monthly_debit_fee, :decimal
    add_column :comparisons, :next_day_funding_fee, :decimal
    add_column :comparisons, :amex_per_item_fee, :decimal
    add_column :comparisons, :amex_bp_mark_up, :integer
    add_column :comparisons, :application_fee, :decimal
    add_column :comparisons, :per_batch_fee, :decimal
    add_column :comparisons, :check_card_qual, :decimal
    add_column :comparisons, :check_card_midqual, :decimal
    add_column :comparisons, :check_card_nonqual, :decimal
    add_column :comparisons, :credit_qual, :decimal
    add_column :comparisons, :credit_midqual, :decimal
    add_column :comparisons, :credit_nonqual, :decimal
    add_column :comparisons, :swiped_flat_rate, :decimal
    add_column :comparisons, :keyed_flat_rate, :decimal
    add_column :comparisons, :tier_check_card_per_item_surcharge, :decimal
    add_column :comparisons, :tier_credit_per_item_surcharge, :decimal
  end
end
