class RemoveMinutesFromCoursesAndChapters < ActiveRecord::Migration
  def change
  	remove_column :courses, :minutes, :integer
  	remove_column :chapters, :minutes, :integer
  end
end
