class Loan < ActiveRecord::Base
	belongs_to :lenders
	belongs_to :borrower
	has_many :bids
end
