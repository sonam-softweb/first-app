class User < ActiveRecord::Base
#	belongs_to :manager, :foreign_key => "join_id"
#	belongs_to :installer, :foreign_key => "join_id"
#	belongs_to :borrower, :foreign_key => "join_id"
#	belongs_to :lender, :foreign_key => "join_id"

#	belongs_to :manager
#	belongs_to :installer
#	belongs_to :borrower
#	belongs_to :lender


  #acts_as_authentic do |c|
   # c.login_field = :email
  #end
  has_many :user_rights

  has_many :borrowers, :through => :user_rights
  has_many :lenders, :through => :user_rights
  has_many :installers, :through => :user_rights
  has_many :managers, :through => :user_rights
  def deliver_password_reset_instructions!
    chars = (('a'..'z').to_a + ('0'..'9').to_a) - %w(i o 0 1 l 0)
    token = (1..15).collect{|a| chars[rand(chars.size)] }.join
    self.password_reset_token = token
    self.save
    Emailer.deliver_password_reset_instructions(self)
  end

end
