class AddAttachmentDocumentToAdminTasks < ActiveRecord::Migration
  def self.up
    change_table :admin_tasks do |t|
      t.attachment :document
    end
  end

  def self.down
    remove_attachment :admin_tasks, :document
  end
end
