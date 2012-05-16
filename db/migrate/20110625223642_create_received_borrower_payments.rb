class CreateReceivedBorrowerPayments < ActiveRecord::Migration
	def self.up
    	create_table :received_borrower_payments do |t|
			t.column :borrower_id, :integer
			t.column :received_amount, :decimal, :precision =>10, :scale =>2
			t.column :received_date, :date
    	  	t.timestamps
	    end
  	end

  	def self.down
    	drop_table :received_borrower_payments
  	end
end
