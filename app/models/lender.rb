class Lender < ActiveRecord::Base
	has_many :user_rights
	has_many :users, :through => :user_rights
	has_many :bids
	has_many :loans

  validates_presence_of :first_name, :last_name, :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => "Email format invalid", :if => Proc.new { |ph| !ph.email.blank?}
  validates_uniqueness_of :email, :if => Proc.new { |ph| !ph.email.blank?}
 # validate :check_email_uniqueness?, :unless => Proc.new { |u| u.email.nil? }
  validates_numericality_of :phone, :if => Proc.new { |ph| !ph.phone.blank?}

  def validate
    lender_user = User.find(:first, :conditions => ["email = ?", email])
    lender = Lender.find(:first, :conditions => ["email = ?", email])
    if lender.nil? && !lender_user.nil?
      errors.add(:email," has already been taken") #if !errors.include?("Email has already been taken")
    end
  end

end
