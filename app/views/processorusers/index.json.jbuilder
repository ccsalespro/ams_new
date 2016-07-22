json.array!(@processorusers) do |processoruser|
  json.extract! processoruser, :id, :processor_id, :user_id, :agentnumber
  json.url processoruser_url(processoruser, format: :json)
end
