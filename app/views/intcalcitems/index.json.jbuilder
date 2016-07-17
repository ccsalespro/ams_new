json.array!(@intcalcitems) do |intcalcitem|
  json.extract! intcalcitem, :id, :inttype_id, :transactions, :volume
  json.url intcalcitem_url(intcalcitem, format: :json)
end
