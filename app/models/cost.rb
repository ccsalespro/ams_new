class Cost < ActiveRecord::Base

	def self.import(file)
		CSV.foreach(file.path, headers: true, :encoding => 'windows-1251:utf-8') do |row|
			Cost.create! row.to_hash
		end
	end
	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |cost|
				csv << cost.attributes.values_at(*column_names)
			end	
		end
	end
end
