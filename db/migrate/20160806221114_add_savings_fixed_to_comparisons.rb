class AddSavingsFixedToComparisons < ActiveRecord::Migration
  def change
    add_column :comparisons, :savings_fixed, :decimal
  end
end
