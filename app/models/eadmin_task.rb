class EadminTask < ActiveRecord::Base
	resourcify
	belongs_to :admin_tasks
	belongs_to :employee
	belongs_to :user

	def completed?
		completed == 1
	end

	validates :category, :presence => true
	validates :when, :presence => true
	validates :due_date, :presence => true


end
