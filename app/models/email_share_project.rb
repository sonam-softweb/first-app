class EmailShareProject < ActiveRecord::Base
	validates_presence_of :from_email
	validates_presence_of :to_email
end
