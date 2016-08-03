class AddColumnToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :keyed_flat_rate, :decimal
  end
end
