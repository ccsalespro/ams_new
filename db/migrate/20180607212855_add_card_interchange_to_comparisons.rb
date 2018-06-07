class AddCardInterchangeToComparisons < ActiveRecord::Migration
  def change
    add_column :comparisons, :ds_fees, :decimal
    add_column :comparisons, :mc_fees, :decimal
    add_column :comparisons, :vs_fees, :decimal
  end
end
