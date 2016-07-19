class AddDescriptionIdToMerchants < ActiveRecord::Migration
  def change
    add_reference :merchants, :description, index: true, foreign_key: true
  end
end
