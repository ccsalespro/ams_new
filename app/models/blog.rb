class Blog < ActiveRecord::Base
	attr_accessor :gallery_id, :name, :image
	belongs_to :gallery_id
	mount_uploader :image, ImageUploader

end
