class AddPerBatchCostToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :per_batch_cost, :decimal
  end
end
