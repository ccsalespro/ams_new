json.array!(@statements) do |statement|
  json.extract! statement, :id, :month, :trans_fee, :prospect_id
  json.url statement_url(statement, format: :json)
end
