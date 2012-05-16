class Manager < ActiveRecord::Base
	has_many :user_rights
	has_many :users, :through => :user_rights
end
