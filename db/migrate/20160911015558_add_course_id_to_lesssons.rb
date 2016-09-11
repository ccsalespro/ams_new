class AddCourseIdToLesssons < ActiveRecord::Migration
  def change
    add_reference :lessons, :course, index: true, foreign_key: true
  end
end
