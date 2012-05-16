class CreateBids < ActiveRecord::Migration
	def self.up
    	create_table :bids do |t|

		t.column :amount, :decimal, :precision =>10, :scale =>2
		t.column :lender_id, :integer
		t.column :borrower_id, :integer
		t.column :loan_id, :integer

		t.timestamps
    end
end

	def self.down
    	drop_table :bids
	end
end
