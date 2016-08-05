class CreateLessonusers < ActiveRecord::Migration
  def change
    create_table :lessonusers do |t|
    	t.references :user, index: true, foreign_key: true
      t.references :lesson, index: true, foreign_key: true
      t.references :chapter, index: true, foreign_key: true
      t.references :course, index: true, foreign_key: true
      t.datetime :completed_at
    end
  end
end
