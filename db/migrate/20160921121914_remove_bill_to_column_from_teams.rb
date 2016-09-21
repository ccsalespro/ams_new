class RemoveBillToColumnFromTeams < ActiveRecord::Migration
  def change
  	remove_column :teams, :bill_to
  end
end
