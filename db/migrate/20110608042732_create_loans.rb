class CreateLoans < ActiveRecord::Migration
	def self.up
    	create_table :loans do |t|
			t.column :borrower_id, :integer
			t.column :lender_id, :integer
			t.column :lender_percentage, :decimal, :precision =>7, :scale =>6
			t.column :start_date, :date
			t.column :end_date, :date
      	t.timestamps
    	end
  	end

  	def self.down
    	drop_table :loans
  	end
end
