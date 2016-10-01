class Chat < ActiveRecord::Base

	belongs_to :team
	default_scope -> { order(created_at: :asc) }

end
