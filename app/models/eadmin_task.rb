class EadminTask < ActiveRecord::Base
	resourcify
	belongs_to :admin_tasks
	belongs_to :employee
	belongs_to :user

	has_attached_file :document, styles: {thumbnail: "60x60#"}
  validates_attachment :document, content_type: { content_type: "application/pdf" }


	def completed?
		completed == 1
	end

	validates :category, :presence => true
	validates :when_due, :presence => true
	validates :due_date, :presence => true


end
