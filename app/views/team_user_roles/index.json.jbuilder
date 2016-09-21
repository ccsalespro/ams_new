json.array!(@team_user_roles) do |team_user_role|
  json.extract! team_user_role, :id, :name, :description, :bill_to
  json.url team_user_role_url(team_user_role, format: :json)
end
