class AddAmexCostToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :amex_per_item_cost, :decimal
    add_column :statements, :amex_percentage_cost, :decimal
  end
end
