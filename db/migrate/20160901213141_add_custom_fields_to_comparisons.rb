class AddCustomFieldsToComparisons < ActiveRecord::Migration
  def change
    add_column :comparisons, :custom_monthly_fees, :decimal
    add_column :comparisons, :custom_annual_fees, :decimal
    add_column :comparisons, :custom_vmd_per_item_fee, :decimal
    add_column :comparisons, :custom_vmd_volume_bp, :decimal
    add_column :comparisons, :custom_amex_per_item, :decimal
    add_column :comparisons, :custom_amex_volume_bp, :decimal
    add_column :comparisons, :custom_pin_per_item, :decimal
    add_column :comparisons, :custom_pin_volume_bp, :decimal
    add_column :comparisons, :custom_sales_bonus, :decimal
    add_column :comparisons, :custom_one_time_fee, :decimal
    add_column :comparisons, :custom_total_vmd_per_item_fees, :decimal
    add_column :comparisons, :custom_total_vmd_volume_bp_fees, :decimal
    add_column :comparisons, :custom_total_amex_per_item_fees, :decimal
    add_column :comparisons, :custom_total_amex_volume_bp_fees, :decimal
    add_column :comparisons, :custom_total_pin_per_item_fees, :decimal
    add_column :comparisons, :custom_total_pin_volume_bp_fees, :decimal
    add_column :comparisons, :custom_monthly_fee_costs, :decimal
    add_column :comparisons, :custom_annual_fee_costs, :decimal
    add_column :comparisons, :custom_vmd_per_item_fee_costs, :decimal
    add_column :comparisons, :custom_vmd_volume_bp_costs, :decimal
    add_column :comparisons, :custom_amex_per_item_costs, :decimal
    add_column :comparisons, :custom_amex_volume_bp_costs, :decimal
    add_column :comparisons, :custom_pin_per_item_costs, :decimal
    add_column :comparisons, :custom_pin_volume_bp_costs, :decimal
    add_column :comparisons, :custom_sales_bonus_costs, :decimal
    add_column :comparisons, :custom_one_time_fee_costs, :decimal
    add_column :comparisons, :custom_vmd_per_item_fee_cost, :decimal
    add_column :comparisons, :custom_vmd_volume_bp_cost, :decimal
    add_column :comparisons, :custom_amex_per_item_cost, :decimal
    add_column :comparisons, :custom_amex_volume_bp_cost, :decimal
    add_column :comparisons, :custom_pin_per_item_cost, :decimal
    add_column :comparisons, :custom_pin_volume_bp_cost, :decimal
  end
end
