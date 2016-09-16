json.array!(@teams) do |team|
  json.extract! team, :id, :name, :bill_to
  json.url team_url(team, format: :json)
end
