class AddSystemIdToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :system_id, :integer
  end
end
