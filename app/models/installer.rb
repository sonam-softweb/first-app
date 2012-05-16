class Installer < ActiveRecord::Base
	has_many :user_rights
	has_many :users, :through => :user_rights

    validates_presence_of :first_name, :last_name, :email    
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => "Email format invalid"
    validates_uniqueness_of :email, :message => "Email already registered"
    validates_numericality_of :phone, :message => "Phone length incorrect"
end
