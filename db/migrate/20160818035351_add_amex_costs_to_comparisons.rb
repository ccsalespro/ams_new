class AddAmexCostsToComparisons < ActiveRecord::Migration
  def change
    add_column :comparisons, :amex_per_item_cost, :decimal
    add_column :comparisons, :amex_percentage_cost, :decimal
  end
end
