class Intitem < ActiveRecord::Base
  belongs_to :merchant
  belongs_to :inttype

  def self.import(file)
		CSV.foreach(file.path, headers: true, :encoding => 'windows-1251:utf-8') do |row|
			Intitem.create! row.to_hash
		end	
	end
end
