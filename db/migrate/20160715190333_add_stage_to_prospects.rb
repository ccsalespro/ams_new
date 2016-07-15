class AddStageToProspects < ActiveRecord::Migration
  def change
  	add_column :prospects, :stage_id, :integer
  end
end
