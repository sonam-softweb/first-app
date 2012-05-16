class Lender < ActiveRecord::Base
	has_many :user_rights
	has_many :users, :through => :user_rights
	has_many :bids
	has_many :loans
end
