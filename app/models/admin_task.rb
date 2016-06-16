class AdminTask < ActiveRecord::Base
	#attr_accessor :document_content_type
	#attr_accessor :document_file_name

	resourcify

	belongs_to :user
	has_many :eadmin_tasks




	has_attached_file :document
	validates_attachment :document, content_type: { content_type: "application/pdf" }
  #do_not_validate_attachment_file_type :document
  #validates_attachment :document, :presence => true, :content_type => { :content_type => "application/pdf" }
  #validate :check_document_present



	validates :category, :presence => true
	validates :when, :presence => true
	validates :due_date, :presence => true






end
