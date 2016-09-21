class CreateTeamUserRoles < ActiveRecord::Migration
  def change
    create_table :team_user_roles do |t|
      t.string :name
      t.string :description
      t.boolean :bill_to

      t.timestamps null: false
    end
  end
end
