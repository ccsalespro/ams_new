class Processor < ActiveRecord::Base
	has_many :programs
	has_many :processorusers
	has_many :users, through: :processorusers
end
