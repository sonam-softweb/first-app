class EmailList < ActiveRecord::Base
	has_many :EmailSubscribers
end
