class CreateDueBorrowerPayments < ActiveRecord::Migration
  	def self.up
    	create_table :due_borrower_payments do |t|
			t.column :borrower_id, :integer
			t.column :due_amount, :decimal, :precision =>10, :scale =>2
			t.column :due_date, :date
			t.column :processed, :boolean, :default => false
    	  	t.timestamps
    	end
  	end

  	def self.down
    	drop_table :due_borrower_payments
  	end
end
