class AddFieldToProject < ActiveRecord::Migration
  def self.up
    add_column :projects, :installer_id, :integer, :null => false  
    add_column :projects, :title, :string, :null => false  
    add_column :projects, :description, :text, :null => true
    add_column :projects, :content, :text, :null => true
    add_column :projects, :city, :string, :null => false
    add_column :projects, :state, :string, :null => false
    add_column :projects, :fund_needed, :integer, :null => false
    add_column :projects, :start_date, :datetime, :null => false
    add_column :projects, :end_date, :datetime, :null => false  
  end

  def self.down
    remove_column :projects, :investor_id
    remove_column :projects, :title
    remove_column :projects, :description
    remove_column :projects, :content
    remove_column :projects, :city
    remove_column :projects, :state
    remove_column :projects, :fund_needed
    remove_column :projects, :start_date
    remove_column :projects, :end_date
  end
end
