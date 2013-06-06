json.array!(@tasks) do |task|
  json.extract! task, :title, :description, :deadline, :user_id, :responsible_id
  json.url task_url(task, format: :json)
end