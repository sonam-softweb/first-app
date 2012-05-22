class CreateProjectFunds < ActiveRecord::Migration
  def self.up
    create_table :project_funds do |t|
      t.integer :project_id
      t.integer :investor_id
      t.integer :fund_raised

      t.timestamps
    end
  end

  def self.down
    drop_table :project_funds
  end
end
