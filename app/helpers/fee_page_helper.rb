module FeePageHelper
  # Calculate fee based on inputs from transactions
  # and given fees for a apartment
  #
  # return hash [[ "start_date" => date, "end_date" => date, "start_input" => number, "end_input" => number, "payment" => number, "result" => number]]
  def apartment_debt(start_date_str, end_date_str, fee_id, apartment_id, flat_fee, variable_fee)
    ap = Apartment.find(apartment_id)

    start_date = Date.parse(start_date_str)
    if ap.moved != nil and start_date < ap.moved 
       start_date = ap.moved
    end
    end_date = Date.parse(end_date_str)

    f = Fee.find(fee_id)
    start_date, start_input = f.get_fee_value(start_date, apartment_id, 'input')
    end_date, end_input = f.get_fee_value(end_date, apartment_id, 'input')
    payments = f.get_sum(start_date, end_date, apartment_id, 'payment')

    debt = (end_input-start_input)*variable_fee.to_i + flat_fee.to_i - payments

    return { "start_date" => start_date, "end_date" => end_date, "start_input" => start_input, "end_input" => end_input, "payment" => payments, "result" => debt }
  end
  def check_result_ok(start_date, end_date, start_input, end_input, payment, result)
    if ( start_date == end_date )
      return false
    end
    if result > payment 
      return false
    end
    return true
  end
end
