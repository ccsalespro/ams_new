class AddColumnsToComparisons < ActiveRecord::Migration
  def change
    add_column :comparisons, :total_vs_access_fees, :decimal
    add_column :comparisons, :total_mc_access_fees, :decimal
    add_column :comparisons, :total_ds_access_fees, :decimal
  end
end
