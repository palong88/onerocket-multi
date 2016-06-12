class AdminTask < ActiveRecord::Base

	resourcify

	belongs_to :user
	has_many :eadmin_tasks
	

	has_attached_file :document, styles: {thumbnail: "60x60#"}
  validates_attachment :document, content_type: { content_type: "application/pdf" }

	validates :category, :presence => true
	validates :when, :presence => true
	validates :due_date, :presence => true

	
end
