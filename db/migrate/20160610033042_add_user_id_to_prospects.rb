class AddUserIdToProspects < ActiveRecord::Migration
  def change
    add_column :prospects, :user_id, :integer
    add_index :prospects, :user_id
  end
end
