class AddIndexToProspects < ActiveRecord::Migration
  def change
  	add_index :statements, :prospect_id
  end
end
