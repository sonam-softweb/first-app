class CreateEmailLists < ActiveRecord::Migration
	def self.up
    	create_table :email_lists do |t|
			t.column :list_name, :string
			t.column :list_description, :string			
	      	t.timestamps
    	end

		EmailList.create :list_name => "New Listings", :list_description => "New project listing notification"
		EmailList.create :list_name => "Newsletter", :list_description => "CollectiveSun general newsletter"

  	end

  	def self.down
    	drop_table :email_lists
  	end
end
