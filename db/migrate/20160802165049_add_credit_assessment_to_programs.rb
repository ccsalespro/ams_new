class AddCreditAssessmentToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :vs_check_card_per_item, :decimal
    add_column :programs, :vs_check_card_access_percentage, :integer
  end
end
