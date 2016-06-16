class EadminTask < ActiveRecord::Base
	#attr_accessor :document_content_type
	#attr_accessor :document_file_name

	resourcify

	belongs_to :admin_tasks
	belongs_to :employee
	belongs_to :user

	has_attached_file :document
	validates_attachment :document, content_type: { content_type: "application/pdf" }
  #do_not_validate_attachment_file_type :document
  #validates_attachment :document, :presence => false, :content_type => { :content_type => "application/pdf" }
  #validate :check_document_present

	def completed?
		completed == 1
	end
	
	def not_completed?
		completed == 0
	end

	validates :category, :presence => true
	validates :when_due, :presence => true
	validates :due_date, :presence => true




end
