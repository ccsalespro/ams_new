class AddCostsToInttableitems < ActiveRecord::Migration
  def change
    add_column :inttableitems, :costs, :decimal
  end
end
