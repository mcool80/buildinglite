json.array!(@fee_transactions) do |fee_transaction|
  json.extract! fee_transaction, :id, :start_date, :end_date, :transaction_type, :value, :fee_id, :apartment_id
  json.url fee_transaction_url(fee_transaction, format: :json)
end
