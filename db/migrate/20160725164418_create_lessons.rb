class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :title
      t.string :video
      t.integer :minutes

      t.timestamps null: false
    end
  end
end
