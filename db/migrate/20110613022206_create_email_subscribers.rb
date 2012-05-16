class CreateEmailSubscribers < ActiveRecord::Migration
	def self.up
    	create_table :email_subscribers do |t|
			t.column :first_name, :string
			t.column :last_name, :string
			t.column :email, :string
			t.column :zip_code, :string
			t.column :email_list_id, :integer
	      	t.timestamps
    	end

		EmailSubscriber.create :first_name => "Lee", :last_name => "Barken", :email => "barken@gmail.com", :email_list_id => "1"

  	end

  	def self.down
    	drop_table :email_subscribers
  	end
end
