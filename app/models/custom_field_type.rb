class CustomFieldType < ActiveRecord::Base
  has_many :custom_fields
  has_many :cc_fields

  	def self.import(file)
		CSV.foreach(file.path, headers: true, :encoding => 'windows-1251:utf-8') do |row|
			CustomFieldType.create! row.to_hash
		end	
	end
end
