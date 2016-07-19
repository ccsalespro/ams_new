class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :prospect_id
      t.text :body
      t.references :prospect, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end