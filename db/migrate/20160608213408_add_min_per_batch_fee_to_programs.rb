class AddMinPerBatchFeeToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :min_per_batch_fee, :decimal
  end
end
