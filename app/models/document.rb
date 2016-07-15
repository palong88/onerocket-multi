class Document < ActiveRecord::Base
  belongs_to :team

  has_attached_file :file
  validates_attachment :file, content_type: { content_type: "application/pdf" }
  #do_not_validate_attachment_file_type :document
  #validates_attachment :document, :presence => true, :content_type => { :content_type => "application/pdf" }
  #validate :check_document_present

end
