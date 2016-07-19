class Merchant < ActiveRecord::Base
	has_many :intitems
	has_many :inttypes, through: :intitems
	belongs_to :description
	def self.import(file)
		CSV.foreach(file.path, headers: true, :encoding => 'windows-1251:utf-8') do |row|
			Merchant.create! row.to_hash
		end	
	end
	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |merchant|
				csv << merchant.attributes.values_at(*column_names)
			end	
		end
	end
end
