class EmailSubscriber < ActiveRecord::Base
	belongs_to :EmailList
	validates_presence_of :email
	validates_numericality_of :zip_code, :allow_blank => true
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create	
end
