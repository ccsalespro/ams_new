class AddNumberOfBatchesToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :c_number_of_batches, :integer
  end
end
