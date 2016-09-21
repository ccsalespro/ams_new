class AddTeamTypeReferenceToTeams < ActiveRecord::Migration
  def change
    add_reference :teams, :team_type, index: true, foreign_key: true
  end
end
