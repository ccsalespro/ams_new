class AddGrossMarginFixedToComparisons < ActiveRecord::Migration
  def change
    add_column :comparisons, :gross_margin_fixed, :decimal
  end
end
