class Description < ActiveRecord::Base
  has_many :prospects

  def self.import(file)
		CSV.foreach(file.path, headers: true, :encoding => 'windows-1251:utf-8') do |row|
			Description.create! row.to_hash
		end	
	end

  searchable do
	text :business_type_secondary
	text :business_type_primary
  end

end
