class AddTextAreaToComparisons < ActiveRecord::Migration
  def change
    add_column :comparisons, :notes, :text
  end
end
