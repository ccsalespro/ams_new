class Course < ActiveRecord::Base
  has_many :chapters, dependent: :destroy
   has_many :courseusers, dependent: :destroy
  has_many :users, through: :courseusers
  has_many :lessons
  belongs_to :user

  def self.import(file)
		CSV.foreach(file.path, headers: true, :encoding => 'windows-1251:utf-8') do |row|
			Course.create! row.to_hash
		end	
	end
end
