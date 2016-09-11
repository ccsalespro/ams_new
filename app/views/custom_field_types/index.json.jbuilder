json.array!(@custom_field_types) do |custom_field_type|
  json.extract! custom_field_type, :id, :name, :description, :custom_field_id
  json.url custom_field_type_url(custom_field_type, format: :json)
end
