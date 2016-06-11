class AddColumnsToProspects < ActiveRecord::Migration
  def change
    add_column :prospects, :description_primary, :string
    add_column :prospects, :description_secondary, :string
  end
end
