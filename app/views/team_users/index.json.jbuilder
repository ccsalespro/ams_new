json.array!(@team_users) do |team_user|
  json.extract! team_user, :id, :user_id, :team_id, :role
  json.url team_user_url(team_user, format: :json)
end
