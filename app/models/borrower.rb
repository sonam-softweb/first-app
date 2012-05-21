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

  validates_presence_of :first_name, :last_name, :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => "Email format invalid", :if => Proc.new { |ph| !ph.email.blank?}
  validates_uniqueness_of :email, :if => Proc.new { |ph| !ph.email.blank?}
  validates_numericality_of :phone, :if => Proc.new { |ph| !ph.phone.blank?}
  def validate
    borrower_user = User.find(:first, :conditions => ["email = ?", email])
    borrower = Borrower.find(:first, :conditions => ["email = ?", email])
    if borrower.nil? && !borrower_user.nil?
      errors.add(:email," has already been taken") #if !errors.include?("Email has already been taken")
    end
  end
end
