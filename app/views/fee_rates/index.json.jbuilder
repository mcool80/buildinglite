json.array!(@fee_rates) do |fee_rate|
  json.extract! fee_rate, :id, :start_date, :end_date, :rate_apartment, :rate_cost, :fee_id
  json.url fee_rate_url(fee_rate, format: :json)
end
