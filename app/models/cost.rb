class Cost < ActiveRecord::Base
	has_and_belongs_to_many :statements

	def self.import(file)
		CSV.foreach(file.path, headers: true, :encoding => 'windows-1251:utf-8') do |row|
			Cost.create! row.to_hash
		end	
	end
end
