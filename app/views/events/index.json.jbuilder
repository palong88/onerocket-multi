json.array!(@events) do |event|
  json.extract! event, :id, :name, :organizer, :organizer_email, :location, :event_date, :team_id
  json.url event_url(event, format: :json)
end
