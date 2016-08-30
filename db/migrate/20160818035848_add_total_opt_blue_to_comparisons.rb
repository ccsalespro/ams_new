class AddTotalOptBlueToComparisons < ActiveRecord::Migration
  def change
    add_column :comparisons, :amex_total_opt_blue, :decimal
  end
end
