class AddSwipedVolumeToStatements < ActiveRecord::Migration
  def change
    add_column :statements, :swiped_vol, :decimal
    add_column :statements, :amex_percent, :decimal
  end
end
