class AddStructureIdToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :structure_id, :integer
  end
end
