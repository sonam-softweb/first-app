class Project < ActiveRecord::Base
  belongs_to :installer

  validates_presence_of :title, :fund_needed, :start_date, :end_date
  validates_numericality_of :fund_needed, :if => Proc.new { |ph| !ph.fund_needed.blank?}
end
