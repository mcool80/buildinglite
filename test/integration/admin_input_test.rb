require 'test_helper'

class AdminInputTest < ActionDispatch::IntegrationTest 
  setup do
    Capybara.default_driver = :webkit
    visit '/users/sign_in?locale=en'
    click_link 'Logout' if page.has_link?('Logout')
    visit '/users/sign_in?locale=en'
    within '#new_user' do
      fill_in 'user_email', :with => 'admin@attedera.com'
      fill_in 'user_password', :with => 'password'
      click_button 'Login'
    end

    @fee_transaction = fee_transactions(:six)
    @fee_transaction_payment = fee_transactions(:seven)
    @apartment = apartments(:two)
  end

  def get_admin_page (fee, apartment)
    # select apartment
    visit '/fee_page/administrate/'+fee.id.to_s+"?locale=en"
    click_link 'Add input', match: :first
    # add payment to apartment
    select apartment.address, :from => 'apartment[id]'
    assert_equal apartment.id, find('#apartment_id', match: :first).value.to_i

  end

  def add_input (fee_transaction, transaction_type)
    get_admin_page fee_transaction.fee, fee_transaction.apartment

    before_count = page.all('#fee-table tr').size
    within '#new_fee_transaction' do
      fill_in 'fee_transaction[start_date]', :with => (fee_transaction.start_date + 30.days).strftime('%d/%m/%Y')
      fill_in 'fee_transaction[value]', :with => fee_transaction.value
      select 'Changed payment', :from => 'fee_transaction[transaction_type]'
      click_button 'Save'
      wait_for_ajax 
    end
    # check payment has added
    visit current_path
    assert_not_equal before_count, page.all('#fee-table tr').size
  end

  test "add input for apartment" do
    # select apartment
    # add input to apartment
    # check input has added
    assert false, "Not implemented"
  end
  
  test "change payment for apartment" do
    add_input @fee_transaction_payment, 'Changed input'
    add_input @fee_transaction, 'Inputed value'
  end

  def click_links
    within '#fee-table' do
      if not find_all(:link, 'Destroy') then
        return
      end
      click_link('Destroy', match: :first) do
        accept_confirm
      end
      wait_for_ajax 
    end
  end

  test "admin destroy value in list" do
    get_admin_page @fee_transaction.fee, @apartment
    # Click all destroy links
    click_links while find_all(:link, 'Destroy').size > 0
    get_admin_page @fee_transaction.fee, @apartment
    # only header left
    assert_equal 1, page.all('#fee-table tr').size
  end
end
