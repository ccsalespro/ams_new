json.array!(@costs) do |cost|
  json.extract! cost, :id, :business_type, :payment_type, :low_ticket, :high_ticket, :per_item_value, :percentage_value
  json.url cost_url(cost, format: :json)
end
