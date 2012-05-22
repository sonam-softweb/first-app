class AddApproveToProject < ActiveRecord::Migration
  def self.up
    add_column :projects, :status, :string, :default => "Under Review"  # SubmittedByInstaller, Under Review, Approved, Displayed, FullySubscribed, Funded, Denied, Inactive
  end

  def self.down
    remove_column :projects, :status
  end
end
