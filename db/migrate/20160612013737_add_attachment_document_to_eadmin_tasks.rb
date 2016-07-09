class AddAttachmentDocumentToEadminTasks < ActiveRecord::Migration
  def self.up
    change_table :eadmin_tasks do |t|
      t.attachment :document
    end
  end

  def self.down
    remove_attachment :eadmin_tasks, :document
  end
end
