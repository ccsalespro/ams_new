class AddDescriptionIdToProspects < ActiveRecord::Migration
  def change
    add_column :prospects, :description_id, :integer
    add_index :prospects, :description_id
  end
end
