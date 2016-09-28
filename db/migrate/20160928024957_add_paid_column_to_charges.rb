class AddPaidColumnToCharges < ActiveRecord::Migration
  def change
    add_column :charges, :paid, :boolean
  end
end
