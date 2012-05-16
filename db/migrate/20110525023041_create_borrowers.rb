class CreateBorrowers < ActiveRecord::Migration
  def self.up
    create_table :borrowers do |t|

		t.column :status, :string, :default => "Under Review"  # SubmittedByInstaller, Under Review, Approved, Displayed, FullySubscribed, Funded, Denied, Inactive
		t.column :first_name, :string
		t.column :last_name, :string
		t.column :screen_name, :string
		t.column :email, :string
#		t.column :email_verified, :string # -1 True, 0 False, n/a if referred by somebody
		t.column :headline, :string
		t.column :description, :string
		t.column :street_address, :string
		t.column :city, :string
		t.column :state, :string
		t.column :zip, :string
		t.column :latitude, :float
		t.column :longitude, :float
		t.column :phone, :string
		t.column :ss, :string
		t.column :cc_number, :string
		t.column :cc_expiration, :string
		t.column :cc_cid, :string
		t.column :bank_account, :string
		t.column :bank_routing, :string
		t.column :system_size, :string
		t.column :system_price, :string
		t.column :csun_ranking, :string
		t.column :password, :string
		t.column :our_notes, :text
		t.column :approval_date, :datetime
		t.column :expiration_date, :datetime
		t.column :installer_id, :integer
#		t.column :user_id, :integer
		t.column :monthly_payment, :decimal, :precision =>10, :scale =>2
		t.column :nfp_category, :string  # which not-fot-profit category?

		# Photos

      	t.column :photo_file_name, :string
		t.column :photo_content_type, :string
		t.column :photo_file_size, :integer
      	t.column :photo_updated_at, :datetime		
				
      	t.timestamps
    end

	Borrower.create :email => "borrower1@collectivesun.com", :first_name => "Bob", :last_name => "Smith", :screen_name => "xyz School", :headline => "Solar for our school", :description => "xyz school is based in xyz.  We provide educational services for low income communities, including K-8 and after school services.  We plan to use this solar system to reduce our monthly electricity expenses and do something great for the environmnet.", :street_address => "123 Main Street", :city=> "San Diego", :state=> "CA", :zip => "92101", :phone=> "6195551212", :ss => "123121234", :bank_account => "1", :bank_routing => "2", :our_notes => "Great Borrower!", :status => "Displayed", :system_size => "5", :system_price => "500000", :installer_id => 1, :approval_date => Time.now().advance(:days =>-1), :expiration_date => Time.now().advance(:days =>20)
	
	Borrower.create :email => "borrower2@collectivesun.com", :first_name => "borrower2", :last_name => "test2", :screen_name => "borrower2", :headline => "We Love Solar!!!", :description => "Thank you for reviewing our page.", :street_address => "454 Apple Street", :city=> "San Diego", :state=> "CA", :zip => "92130", :phone=> "6195555555", :ss => "423121234", :bank_account => "1", :bank_routing => "2", :our_notes => "Great Borrower2!", :status => "Approved", :system_size => "50", :system_price => "20000", :installer_id => 1, :approval_date => Time.now(), :expiration_date => Time.now().advance(:days =>21)

	Borrower.create :email => "borrower3@collectivesun.com", :first_name => "borrower3", :last_name => "test3", :screen_name => "borrower3", :headline => "Solar for a church", :description => "We are a church trying to go solar.", :street_address => "789 Church Street", :city=> "San Diego", :state=> "CA", :zip => "92102", :phone=> "6195555555", :ss => "423121234", :bank_account => "1", :bank_routing => "2", :our_notes => "Great Borrower3!", :status => "Displayed", :system_size => "90", :system_price => "200000", :installer_id => 2, :approval_date => Time.now(), :expiration_date => Time.now().advance(:days =>60)
	
	Borrower.create :email => "borrower4@collectivesun.com", :first_name => "borrower4", :last_name => "test4", :screen_name => "borrower4", :headline => "New Solar Project - Humane Society", :description => "Non-profit going solar.", :street_address => "111 Poodle Ave.", :city=> "San Diego", :state=> "CA", :zip => "92111", :phone=> "6195555555", :ss => "423121234", :bank_account => "1", :bank_routing => "2", :our_notes => "Great Borrower4!", :status => "Displayed", :system_size => "30", :system_price => "15000", :installer_id => 2, :approval_date => Time.now(), :expiration_date => Time.now().advance(:days =>14)

	Borrower.create :email => "borrower5@collectivesun.com", :first_name => "borrower5", :last_name => "test5", :screen_name => "borrower5", :headline => "Solar Project - Test", :description => "Another Non-profit going solar.", :street_address => "222 xyz Ave.", :city=> "San Diego", :state=> "CA", :zip => "92110", :phone=> "6195555555", :ss => "423121234", :bank_account => "1", :bank_routing => "2", :our_notes => "Great Borrower5!", :status => "Displayed", :system_size => "15", :system_price => "22000", :installer_id => 1, :approval_date => Time.now(), :expiration_date => Time.now().advance(:days =>16)
	
	Borrower.create :email => "borrower6@collectivesun.com", :first_name => "borrower6", :last_name => "test6", :screen_name => "borrower6", :headline => "Going Solar - Food Bank", :description => "Food Bank Non-profit going solar.", :street_address => "111 Poodle Ave.", :city=> "San Diego", :state=> "CA", :zip => "92111", :phone=> "6195555555", :ss => "423121234", :bank_account => "1", :bank_routing => "2", :our_notes => "Great Borrower4!", :status => "Displayed", :system_size => "25", :system_price => "33000", :installer_id => 2, :approval_date => Time.now(), :expiration_date => Time.now().advance(:days =>25)

  end

  def self.down
    drop_table :borrowers
  end
end
