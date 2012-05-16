class CreateEmailShareProjects < ActiveRecord::Migration
	def self.up
    	create_table :email_share_projects do |t|
			t.column :from_name, :string
			t.column :from_email, :string
			t.column :to_name, :string
			t.column :to_email, :string
			t.column :message, :string
			t.column :borrower_id, :integer

	     	t.timestamps
    	end
  	end

  	def self.down
    	drop_table :email_share_projects
  	end
end
