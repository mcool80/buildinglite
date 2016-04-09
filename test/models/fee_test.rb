require 'test_helper'

class FeeTest < ActiveSupport::TestCase
  def setup 
    @fee = fees(:one)
  end
  # test "the truth" do
  #   assert true
  # end
  test "last fee value for apartment" do
  end
  test "get sum of payments" do
     # Get sum from 2011-06-01 to 2012-01-01
     ft1 = fee_transactions(:three) # start 2011-05-08
     ft2 = fee_transactions(:five) # start  2011-08-01
     value = ft1.value * 2 + ft2.value * 5
     calc_val = @fee.get_sum(DateTime.new(2011, 6, 1), DateTime.new(2012, 1, 1), ft1.apartment_id, ft1.transaction_type)
     assert_equal value, calc_val
     
  end
end
