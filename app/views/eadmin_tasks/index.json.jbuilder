json.array!(@eadmin_tasks) do |eadmin_task|
  json.extract! eadmin_task, :id, :title, :description, :media, :due_date, :category, :when_due, :completed, :completed_at
  json.url eadmin_task_url(eadmin_task, format: :json)
end
