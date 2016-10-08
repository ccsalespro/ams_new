class AddProcessorEmployeeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :processor_employee, :boolean
  end
end
