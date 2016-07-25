class AddCourseIdToChapters < ActiveRecord::Migration
  def change
    add_reference :chapters, :course, index: true, foreign_key: true
  end
end
