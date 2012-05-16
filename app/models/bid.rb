class Bid < ActiveRecord::Base
	belongs_to :lender
	belongs_to :borrower
	belongs_to :loan

	#validates_numericality_of :amount, :greater_than_or_equal_to => 20

end
