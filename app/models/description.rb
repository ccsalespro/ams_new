class Description < ActiveRecord::Base
  has_many :prospects
  has_many :merchants
  default_scope -> { order(business_type_primary: :asc) }
  default_scope -> { order(business_type_secondary: :asc) }
  	def self.import(file)
		CSV.foreach(file.path, headers: true, :encoding => 'windows-1251:utf-8') do |row|
			Description.create! row.to_hash
		end	
	end
	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |description|
				csv << description.attributes.values_at(*column_names)
			end	
		end
	end
end
