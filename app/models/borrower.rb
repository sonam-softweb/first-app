class Borrower < ActiveRecord::Base
	has_many :user_rights
	has_many :users, :through => :user_rights
	has_many :bids
	has_one :loan
	has_many :due_borrower_payments
	has_many :received_borrower_payments
	#has_attached_file :photo, :styles => { :thumb => "100x100#", :medium => "300x300>", :large => "600x600>" }
  has_many :photos, :dependent => :destroy
  accepts_nested_attributes_for :photos , :allow_destroy => true, :reject_if => lambda { |t| t['photo'].nil? }


end
