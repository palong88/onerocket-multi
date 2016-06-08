class AdminTask < ActiveRecord::Base

	resourcify
	belongs_to :user
	has_many :eadmin_tasks
	

	validates :category, :presence => true
	validates :when, :presence => true
	validates :due_date, :presence => true
end
