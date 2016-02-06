require 'test_helper'

class FeeTransactionTest < ActiveSupport::TestCase
  test "to get currency" do
    @fee_transaction = fee_transactions(:one)
    assert_not @fee_transaction.is_currency, "Currency is is input and not currency"
    @fee_transaction = fee_transactions(:four) 
    assert @fee_transaction.is_currency, "Should be currency and not an input"
  end
end
