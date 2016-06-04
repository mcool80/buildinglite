require 'test_helper'

class UserInputTest < ActionDispatch::IntegrationTest 
  setup do
    Capybara.default_driver = :webkit
    visit '/users/sign_in?locale=en'
    click_link 'Logout' if page.has_link?('Logout')
    visit '/users/sign_in?locale=en'
    within '#new_user' do
      fill_in 'user_email', :with => 'user_int_test@test.com'
      fill_in 'user_password', :with => 'password'
      click_button 'Login'
    end

    @fee_transaction = fee_transactions(:ten)
  end

  # test "the truth" do
  #   assert true
  # end
  test "add value to list" do
    # get list of fee_transactions
    visit '/fee_page/'+@fee_transaction.fee.id.to_s+"?locale=en"
    before_count = page.all('#fee-table tr').size
    # add value in input box and submit
    # check that value is added
    within('#new_fee_transaction') do
      fill_in 'fee_transaction[start_date]', :with => (@fee_transaction.start_date + 30.days).strftime('%d/%m/%Y')
      fill_in 'fee_transaction[value]', :with => @fee_transaction.value
      click_button 'Save'
      wait_for_ajax 
    end
    visit '/fee_page/'+@fee_transaction.fee.id.to_s+"?locale=en"
    assert_not_equal before_count, page.all('#fee-table tr').size
  end

  test "destroy value in list" do
    # get list of fee_transactions
    visit '/fee_page/'+@fee_transaction.fee.id.to_s+"?locale=en"
    find('footer')
    before_count = page.all('#fee-table tr').size
    # click destroy on inputted value 
    # check that value is destroyed
    print page.html
#    dismiss_confirm(:wait => 60) do 
#      find(:link, 'Destroy', match: :first).click
#    end
#    visit '/fee_page/'+@fee_transaction.fee.id.to_s+"?locale=en"
#    find('footer')
#    assert_equal before_count, page.all('#fee-table tr').size

    page.accept_confirm do
      find(:link, 'Destroy', match: :first).click
    end
    visit '/fee_page/'+@fee_transaction.fee.id.to_s+"?locale=en"
    find('footer')
    assert_not_equal before_count, page.all('#fee-table tr').size
  end
end
