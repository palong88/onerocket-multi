json.array!(@stakeholders) do |stakeholder|
  json.extract! stakeholder, :id, :name, :email, :department, :template
  json.url stakeholder_url(stakeholder, format: :json)
end
