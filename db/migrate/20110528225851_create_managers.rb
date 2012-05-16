class CreateManagers < ActiveRecord::Migration
	def self.up
    	create_table :managers do |t|
			t.column :email, :string
			t.column :first_name, :string
			t.column :last_name, :string
			t.column :user_id, :integer

			t.timestamps
    	end

		Manager.create :email => "m", :first_name => "test", :last_name => "user", :user_id => 1

  	end

	def self.down
    	drop_table :managers
	end
end
