class RemoveCheckCardAvgTicketFromStatements < ActiveRecord::Migration
  def change
  	remove_column :statements, :check_card_avg_ticket
  	remove_column :statements, :check_card_interchange
  end
end
