require 'test_helper'

class FeeTransactionTest < ActiveSupport::TestCase
  test "to get currency" do
    fee_transactions(:one)
    assert_not one.is_currency, "Currency is is input and not currency"
    fee_transactions(:four) 
    assert four.is_currency, "Should be currency and not an input"
    assert true
  end
end
