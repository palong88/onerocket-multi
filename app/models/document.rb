class Document < ActiveRecord::Base
  belongs_to :team

  has_attached_file :file
  validates_attachment :file, content_type: { content_type: "application/pdf" },   :styles => {
    :thumb => ["200x200>", :pdf],
    :medium => ["500x500>", :png]}


    FileIcon = {

        :pdf => '/pdf.png',

        :doc => '/word.png'

        #... and other any file types, all like this

        }

end
