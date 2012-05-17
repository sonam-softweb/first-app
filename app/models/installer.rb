class Installer < ActiveRecord::Base
	has_many :user_rights
	has_many :users, :through => :user_rights

  validates_presence_of :first_name, :last_name, :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => "Email format invalid", :if => Proc.new { |ph| !ph.email.blank?}
  validates_uniqueness_of :email, :if => Proc.new { |ph| !ph.email.blank?}
  validates_numericality_of :phone
  def validate
    installer_user = User.find(:first, :conditions => ["email = ?", email])
    installer = Installer.find(:first, :conditions => ["email = ?", email])
    if lender.nil? && !installer_user.nil?
      errors.add(:email," has already been taken") #if !errors.include?("Email has already been taken")
    end
  end
end
