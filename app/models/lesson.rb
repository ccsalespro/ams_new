class Lesson < ActiveRecord::Base
  belongs_to :chapter
  belongs_to :course
  has_many :lessonusers, dependent: :destroy

  	def self.import(file)
		CSV.foreach(file.path, headers: true) do |row|
			Lesson.create! row.to_hash
		end
	end

	def completed?
		!completed_at.blank?
	end

  default_scope -> { order(lesson_number: :asc) }

end
