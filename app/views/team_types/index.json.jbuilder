json.array!(@team_types) do |team_type|
  json.extract! team_type, :id, :description
  json.url team_type_url(team_type, format: :json)
end
