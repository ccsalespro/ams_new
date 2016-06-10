json.array!(@descriptions) do |description|
  json.extract! description, :id, :business_type_primary, :business_type_secondary, :prospect_id
  json.url description_url(description, format: :json)
end
