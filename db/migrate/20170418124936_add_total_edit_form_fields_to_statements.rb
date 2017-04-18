class AddTotalEditFormFieldsToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :default_basis_points, :decimal
    add_column :statements, :default_per_item_fee, :decimal
    add_column :statements, :total_passthrough, :decimal
    add_column :statements, :initial_edit_complete, :boolean, :default => false
  end
end
