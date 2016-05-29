module FeePageHelper
  # Calculate fee based on inputs from transactions
  # and given fees for a apartment
  #
  # return hash [[ "start_date" => date, "end_date" => date, "start_input" => number, "end_input" => number, "payment" => number, "result" => number]]
  def apartment_debt(start_date_str, end_date_str, fee_id, apartment_id, flat_fee, variable_fee)
    ap = Apartment.find(apartment_id)

    start_date = Date.parse(start_date_str)
    end_date = Date.parse(end_date_str)

    start_date = ap.moved if ap.moved and start_date < ap.moved 
    start_date = end_date if start_date > end_date

    f = Fee.find(fee_id)

    start_fee_transaction = ap.find_fee_transaction(f, start_date, 'input')
    end_fee_transaction = ap.find_fee_transaction(f, end_date, 'input')

    if (not start_fee_transaction.nil?) and (not end_fee_transaction.nil?) then
      payments = f.get_sum(start_fee_transaction.start_date, end_fee_transaction.start_date, apartment_id, 'payment')
      debt = payments - ( (end_fee_transaction.value-start_fee_transaction.value) * variable_fee.to_i + flat_fee.to_i)
    else
      payments = 0
      debt = nil 
    end

    return { "start_fee_transaction" => start_fee_transaction, "end_fee_transaction" => end_fee_transaction, "payment" => payments, "result" => debt }
  end
end
