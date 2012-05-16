class CreateLenders < ActiveRecord::Migration
  def self.up
    create_table :lenders do |t|

		t.column :first_name, :string
		t.column :last_name, :string
		t.column :email, :string
		t.column :screen_name, :string
#		t.column :email_verified, :string # -1 True, 0 False, n/a if referred by somebody
		t.column :street_address, :string
		t.column :city, :string
		t.column :state, :string
		t.column :zip, :string
		t.column :phone, :string
		t.column :ss, :string
		t.column :bank_account, :string
		t.column :bank_routing, :string
#		t.column :password, :string
		t.column :our_notes, :text
		t.column :bank_balance, :float, :default => 0
		t.column :status, :string, :default => "Under Review"  # Under Review, Approved, Denied, Inactive
		t.column :user_id, :integer

      t.timestamps
    end

	Lender.create :email => "lender1@collectivesun.com", :first_name => "lender", :last_name => "test", :screen_name => "lender1", :street_address => "123 Main Street", :city=> "San Diego", :state=> "CA", :phone=> "6195551212", :ss => "123121234", :bank_account => "1", :bank_routing => "2", :our_notes => "Great Lender!", :bank_balance => 100, :status => "Approved", :user_id => 4

	Lender.create :email => "lender2@collectivesun.com", :first_name => "lender2", :last_name => "test2", :screen_name => "lender2", :street_address => "456 Main Street", :city=> "San Diego", :state=> "CA", :phone=> "6195551212", :ss => "123121234", :bank_account => "1", :bank_routing => "2", :our_notes => "Great Lender2!", :bank_balance => 100, :status => "Approved", :user_id => 5

  end

  def self.down
    drop_table :lenders
  end
end
