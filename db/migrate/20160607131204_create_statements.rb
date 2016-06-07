class CreateStatements < ActiveRecord::Migration
  def change
    create_table :statements do |t|
      t.string :month
      t.decimal :trans_fee
      t.belongs_to :prospect, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
