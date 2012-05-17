class Installer < ActiveRecord::Base
	has_many :user_rights
	has_many :users, :through => :user_rights

  validates_presence_of :first_name, :last_name, :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => "Email format invalid"
  validates_uniqueness_of :email, :if => Proc.new { |ph| !ph.email.blank?}
  validates_numericality_of :phone
  def validate
    lender_user = User.find(:first, :conditions => ["email = ?", email])
    lender = Lender.find(:first, :conditions => ["email = ?", email])
    if lender.nil? && !lender_user.nil?
      errors.add(:email," has already been taken") #if !errors.include?("Email has already been taken")
    end
  end
end
