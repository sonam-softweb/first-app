#require "paperclip"
class Photo < ActiveRecord::Base
#	belongs_to :borrower, :polymorphic => true
	belongs_to :borrower
	has_attached_file :photo, :styles => { :thumb => "100x100#", :medium => "300x300>", :large => "600x600>" }
end
