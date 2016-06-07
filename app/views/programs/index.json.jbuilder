json.array!(@programs) do |program|
  json.extract! program, :id, :name, :per_item_cost, :min_per_item_fee, :Processor_id
  json.url program_url(program, format: :json)
end
