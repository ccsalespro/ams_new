json.array!(@processors) do |processor|
  json.extract! processor, :id, :name
  json.url processor_url(processor, format: :json)
end
