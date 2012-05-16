class CreateUserRights < ActiveRecord::Migration
	def self.up
    	create_table :user_rights do |t|

			t.column :user_id, :integer
			t.column :borrower_id, :integer
			t.column :lender_id, :integer
			t.column :installer_id, :integer
			t.column :manager_id, :integer
			t.column :security_level, :string #The security level for this particular right

	      	t.timestamps
    	end

		UserRight.create :user_id => 1, :manager_id => 1
		UserRight.create :user_id => 2, :installer_id => 1
		UserRight.create :user_id => 2, :installer_id => 2
		UserRight.create :user_id => 3, :borrower_id => 1
		UserRight.create :user_id => 4, :lender_id => 1
		UserRight.create :user_id => 5, :lender_id => 2
		UserRight.create :user_id => 6, :borrower_id => 2
		UserRight.create :user_id => 7, :installer_id => 1
		UserRight.create :user_id => 8, :borrower_id => 3
		UserRight.create :user_id => 9, :borrower_id => 4
		UserRight.create :user_id => 10, :borrower_id => 5
		UserRight.create :user_id => 11, :borrower_id => 6
	end

  def self.down
    drop_table :user_rights
  end
end
