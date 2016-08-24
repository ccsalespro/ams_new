class Inttype < ActiveRecord::Base
	has_many :intitems
	has_many :merchants, through: :intitems
	has_many :inttableitems
	has_many :statements, through: :inttableitems
	default_scope -> { order(id: :asc) }
	def self.import(file)
		CSV.foreach(file.path, headers: true, :encoding => 'windows-1251:utf-8') do |row|
			Inttype.create! row.to_hash
		end	
	end

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |inttype|
				csv << inttype.attributes.values_at(*column_names)
			end	
		end
	end
end

