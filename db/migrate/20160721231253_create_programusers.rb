class CreateProgramusers < ActiveRecord::Migration
  def change
    create_table :programusers do |t|
      t.references :user, index: true, foreign_key: true
      t.references :program, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
