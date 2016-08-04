class CreateCourseusers < ActiveRecord::Migration
  def change
    create_table :courseusers do |t|
      t.references :user, index: true, foreign_key: true
      t.references :course, index: true, foreign_key: true

    end
  end
end
