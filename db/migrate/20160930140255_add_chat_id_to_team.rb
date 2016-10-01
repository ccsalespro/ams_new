class AddChatIdToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :chat_id, :integer
  end
end
