class UserRight < ActiveRecord::Base
	belongs_to :user
	belongs_to :manager
	belongs_to :borrower
	belongs_to :lender
	belongs_to :installer
end
