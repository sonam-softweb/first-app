class CreateUsers < ActiveRecord::Migration
	def self.up
    	create_table :users do |t|
##			t.column :first_name, :string
##			t.column :last_name, :string
##			t.column :email, :string
#			t.column :password, :string
#			t.column :security_level, :integer
#			t.column :user_type, :string  # CSUN, Installer, Borrower, Lender
#			t.column :manager_id, :integer
#			t.column :installer_id, :integer
#			t.column :borrower_id, :integer			
#			t.column :lender_id, :integer
##			t.column :join_id, :integer

			t.column :screen_name, :string
			t.column :email, :string
			t.column :first_name, :string
			t.column :last_name, :string			
			t.column :address, :string
			t.column :city, :string
			t.column :state, :string
			t.column :zip, :string
			t.column :phone, :string
			t.column :fax, :string
			t.column :password, :string
			
			t.timestamps
    	end

		User.create :password => "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8", :screen_name => "M1", :email => "manager1@collectivesun.com", :first_name => "m", :last_name => "1"
		User.create :password => "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8", :screen_name => "I1", :email => "installer1@collectivesun.com", :first_name => "i", :last_name => "1"		
		User.create :password => "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8", :screen_name => "B1", :email => "borrower1@collectivesun.com", :first_name => "b", :last_name => "1"
		User.create :password => "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8", :screen_name => "L1", :email => "lender1@collectivesun.com", :first_name => "l", :last_name => "1"
		User.create :password => "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8", :screen_name => "L2", :email => "lender2@collectivesun.com", :first_name => "l", :last_name => "2"
		User.create :password => "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8", :screen_name => "B2", :email => "borrower2@collectivesun.com", :first_name => "b", :last_name => "2"		
		User.create :password => "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8", :screen_name => "I2", :email => "installer2@collectivesun.com", :first_name => "i", :last_name => "2"
		User.create :password => "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8", :screen_name => "B3", :email => "borrower3@collectivesun.com", :first_name => "b", :last_name => "3"
		User.create :password => "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8", :screen_name => "B4", :email => "borrower4@collectivesun.com", :first_name => "b", :last_name => "4"
		User.create :password => "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8", :screen_name => "B5", :email => "borrower5@collectivesun.com", :first_name => "b", :last_name => "5"
		User.create :password => "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8", :screen_name => "B6", :email => "borrower6@collectivesun.com", :first_name => "b", :last_name => "6"
		
#		User.create :password => "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8", :user_type => "manager", :manager_id => 1
#		User.create :password => "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8", :user_type => "installer", :installer_id => 1		
#		User.create :password => "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8", :user_type => "borrower", :borrower_id => 1
#		User.create :password => "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8", :user_type => "lender", :lender_id => 1
#		User.create :password => "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8", :user_type => "lender", :lender_id => 2
#		User.create :password => "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8", :user_type => "borrower", :borrower_id => 2
	end

	def self.down
    	drop_table :users
	end

end
