class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :prospect_id
      t.text :body
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :notes, :prospect_id
  end
end
