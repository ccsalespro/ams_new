class Intcalcitem < ActiveRecord::Base
  belongs_to :inttype
  belongs_to :statement
  belongs_to :prospect

    def self.import(file)
		CSV.foreach(file.path, headers: true, :encoding => 'windows-1251:utf-8') do |row|
			Intcalcitem.create! row.to_hash
		end	
	end

    def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.eacgit sth do |intcalcitem|
				csv << intcalcitem.attributes.values_at(*column_names)
			end	
		end
	end

  default_scope -> { order(transactions: :desc) }
end