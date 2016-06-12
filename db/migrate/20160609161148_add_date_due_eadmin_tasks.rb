class AddDateDueEadminTasks < ActiveRecord::Migration
  def change
  	add_column :eadmin_tasks, :date_due, :date
  end
end
