json.array!(@structures) do |structure|
  json.extract! structure, :id, :name
  json.url structure_url(structure, format: :json)
end
