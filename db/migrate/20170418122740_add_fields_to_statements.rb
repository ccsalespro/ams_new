class AddFieldsToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :c_vmd_bp_mark_up, :decimal
    add_column :statements, :c_vmd_per_item_fee, :decimal
    add_column :statements, :c_amex_per_item_fee, :decimal
    add_column :statements, :c_amex_bp_mark_up, :decimal
    add_column :statements, :c_debit_per_item_fee, :decimal
    add_column :statements, :c_check_card_access_per_item, :decimal
    add_column :statements, :c_check_card_access_percentage, :decimal
    add_column :statements, :c_visa_access_per_item, :decimal
    add_column :statements, :c_visa_access_percentage, :decimal
    add_column :statements, :c_mc_access_per_item, :decimal
    add_column :statements, :c_mc_access_percentage, :decimal
    add_column :statements, :c_disc_access_per_item, :decimal
    add_column :statements, :c_disc_access_percentage, :decimal
    add_column :statements, :c_monthly_fees, :decimal
    add_column :statements, :c_monthly_pci_fee, :decimal
    add_column :statements, :c_monthly_debit_fee, :decimal
    add_column :statements, :c_annual_fee, :decimal
    add_column :statements, :c_monthly_next_day_funding_fee, :decimal
    add_column :statements, :c_batch_fee, :decimal
    add_column :statements, :c_other_fees, :decimal
  end
end
