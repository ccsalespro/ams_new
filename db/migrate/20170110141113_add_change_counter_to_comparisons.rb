class AddChangeCounterToComparisons < ActiveRecord::Migration
  def change
  	add_column :comparisons, :change_counter, :decimal
  end
end
