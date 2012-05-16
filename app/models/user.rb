class User < ActiveRecord::Base
#	belongs_to :manager, :foreign_key => "join_id"
#	belongs_to :installer, :foreign_key => "join_id"
#	belongs_to :borrower, :foreign_key => "join_id"
#	belongs_to :lender, :foreign_key => "join_id"

#	belongs_to :manager
#	belongs_to :installer
#	belongs_to :borrower
#	belongs_to :lender

  acts_as_authentic do |c|
    c.login_field = :email
  end
	has_many :user_rights

	has_many :borrowers, :through => :user_rights
	has_many :lenders, :through => :user_rights
	has_many :installers, :through => :user_rights
	has_many :managers, :through => :user_rights
  def deliver_password_reset_instructions!
    reset_perishable_token!
    Emailer.deliver_password_reset_instructions(self)
  end
end
