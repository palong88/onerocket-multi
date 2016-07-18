class AddTeamToEadminTasks < ActiveRecord::Migration
  def change
    add_column :eadmin_tasks, :team, :string
  end
end
