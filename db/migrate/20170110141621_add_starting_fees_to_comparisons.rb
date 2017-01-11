class AddStartingFeesToComparisons < ActiveRecord::Migration
  def change
    add_column :comparisons, :starting_per_item, :decimal
    add_column :comparisons, :starting_bp, :decimal
  end
end
