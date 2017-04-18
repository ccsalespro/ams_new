class AddCurrentPassThroughToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :c_network_access_fees, :decimal
    add_column :statements, :c_opt_blue_fees, :decimal
  end
end
