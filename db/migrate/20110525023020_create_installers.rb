class CreateInstallers < ActiveRecord::Migration
  def self.up
    create_table :installers do |t|

		t.column :status, :string, :default => "Under Review"  # Under Review, Approved, Denied, Inactive
		t.column :company_name, :string
		t.column :first_name, :string
		t.column :last_name, :string
#		t.column :screen_name, :string
		t.column :email, :string
		t.column :website, :string
		t.column :street_address, :string
		t.column :city, :string
		t.column :state, :string
		t.column :zip, :string
		t.column :phone, :string
		t.column :fax, :string
		t.column :applicant_comments, :text
		t.column :our_notes, :text
#		t.column :active, :boolean, :default => 1  # If application is "deleted", it becomes "inactive"
		t.column :latitude, :float
		t.column :longitude, :float
#		t.column :password, :string
#		t.column :user_id, :integer
		t.column :client_id_pg, :integer
		t.column :payment_method_id_pg, :integer

		
      	t.timestamps
    end

	Installer.create :email => "installer1@collectivesun.com", :first_name => "installer", :last_name => "test", :website => "www.google.com", :street_address => "123 Main Street", :city=> "San Diego", :state=> "CA", :zip => 92120, :phone=> "6195551212", :fax => "6195551213", :applicant_comments => "This looks like a neat program, how can I participate?", :our_notes => "Great Installer!", :status => "Approved", :company_name => "Awesome Installer, Inc."
	Installer.create :email => "installer2@collectivesun.com", :first_name => "installer2", :last_name => "test2", :website => "www.google.com", :street_address => "456 5th Ave.", :city=> "San Diego", :state=> "CA", :zip => 92101, :phone=> "6195551212", :fax => "6195551213", :applicant_comments => "I would like to be an installer", :our_notes => "Excellent Installer!", :status => "Approved", :company_name => "Mr. Solar Installer, Inc."

  end

  def self.down
    drop_table :installers
  end
end
