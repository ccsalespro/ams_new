json.array!(@intitems) do |intitem|
  json.extract! intitem, :id, :merchant_id, :inttype_id, :mid, :month, :card_type, :transactions, :volume
  json.url intitem_url(intitem, format: :json)
end
