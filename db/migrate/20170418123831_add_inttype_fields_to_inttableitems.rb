class AddInttypeFieldsToInttableitems < ActiveRecord::Migration
  def change
    add_column :inttableitems, :inttype_description, :string
    add_column :inttableitems, :inttype_percent, :decimal
    add_column :inttableitems, :inttype_per_item, :decimal
  end
end
