class CreateEadminTasks < ActiveRecord::Migration
  def change
    create_table :eadmin_tasks do |t|
      t.string :title
      t.string :description
      t.string :media
      t.string :due_date
      t.string :category
      t.string :when_due
      t.integer :completed
      t.time :completed_at

      t.timestamps null: false
    end
  end
end