json.array!(@fees) do |fee|
  json.extract! fee, :id, :name, :payment_interval, :currency, :unit, :community_id
  json.url fee_url(fee, format: :json)
end
