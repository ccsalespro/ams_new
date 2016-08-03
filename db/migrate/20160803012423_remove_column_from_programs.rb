class RemoveColumnFromPrograms < ActiveRecord::Migration
  def change
    remove_column :programs, :keyed_flat_rate_decimal, :string
  end
end
