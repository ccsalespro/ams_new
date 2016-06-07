json.array!(@prospects) do |prospect|
  json.extract! prospect, :id, :business_name, :contact_name
  json.url prospect_url(prospect, format: :json)
end
