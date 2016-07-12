class AddTeamToAdminTasks < ActiveRecord::Migration
  def change
    add_column :admin_tasks, :team, :string
  end
end
