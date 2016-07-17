class CreateInttypes < ActiveRecord::Migration
  def change
    create_table :inttypes do |t|
      t.string :card_type
      t.string :description
      t.decimal :percent
      t.decimal :per_item
      t.decimal :max

      t.timestamps null: false
    end
  end
end
