class CreateLessonusers < ActiveRecord::Migration
  def change
    create_table :lessonusers do |t|
    	t.references :user, index: true, foreign_key: true
      t.references :lesson, index: true, foreign_key: true
    end
  end
end
