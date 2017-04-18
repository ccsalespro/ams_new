class AddSurchargesToComparisons < ActiveRecord::Migration
  def change
    add_column :comparisons, :surcharge_percentage, :decimal
    add_column :comparisons, :total_surcharge_amount, :decimal
  end
end
