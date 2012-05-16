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
   # c.my_config_option = my_value # for available options see documentation in: Authlogic::ActsAsAuthentic
  end # block optional
	has_many :user_rights

	has_many :borrowers, :through => :user_rights
	has_many :lenders, :through => :user_rights
	has_many :installers, :through => :user_rights
	has_many :managers, :through => :user_rights
end
