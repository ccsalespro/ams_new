json.array!(@inttypes) do |inttype|
  json.extract! inttype, :id, :card_type, :description, :percent, :per_item, :max
  json.url inttype_url(inttype, format: :json)
end
