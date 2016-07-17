json.array!(@inttableitems) do |inttableitem|
  json.extract! inttableitem, :id, :inttype_id, :statement_id, :transactions, :volume
  json.url inttableitem_url(inttableitem, format: :json)
end
