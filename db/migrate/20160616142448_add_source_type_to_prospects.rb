class AddSourceTypeToProspects < ActiveRecord::Migration
  def change
    add_column :prospects, :source_type, :string
  end
end
