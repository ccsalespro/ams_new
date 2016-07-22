class Processoruser < ActiveRecord::Base
  belongs_to :processor
  belongs_to :user
end
