class Inttype < ActiveRecord::Base
	has_many :intitems
	has_many :merchants, through: :intitems
	has_many :inttableitems
	has_many :statements, through: :inttableitems
	default_scope -> { order(id: :asc) }
	def self.import(file)
		CSV.foreach(file.path, headers: true, :encoding => 'windows-1251:utf-8') do |row|
			inttype_hash = row.to_hash
			inttype = Inttype.find_by_id(inttype_hash["id"])
			if inttype != nil
				inttype.update_attributes(row.to_hash)
			else
				Inttype.create! row.to_hash
			end
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

