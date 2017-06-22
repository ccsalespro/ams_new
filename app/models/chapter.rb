class Chapter < ActiveRecord::Base
  belongs_to :course
  has_many :lessons, dependent: :destroy
  has_many :chapterusers, dependent: :destroy

  	def self.import(file)
		CSV.foreach(file.path, headers: true, :encoding => 'windows-1251:utf-8') do |row|
			Chapter.create! row.to_hash
		end	
	end
end
