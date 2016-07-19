class AddFinishDateToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :finish_date, :date
  end
end
