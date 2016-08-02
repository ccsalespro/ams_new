class RemoveStructureIdFromPrograms < ActiveRecord::Migration
  def change
    remove_column :programs, :structure_id, :integer
  end
end
