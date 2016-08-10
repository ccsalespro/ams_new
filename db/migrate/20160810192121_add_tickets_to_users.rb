class AddTicketsToUsers < ActiveRecord::Migration
  def change
  	create_table :tickets do |t|
      t.integer :user_id
      t.integer :admin_user_id
      t.text :body
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
