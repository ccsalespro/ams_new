class AddChangeFieldsToComparisons < ActiveRecord::Migration
  def change
    add_column :comparisons, :per_item_change, :decimal
    add_column :comparisons, :bp_change, :decimal
  end
end
