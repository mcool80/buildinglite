ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
  include Devise::TestHelpers

  setup do
    sign_in users(:one)
    @login_admin = users(:two)
    @login_user = users(:one)
    @login_other_admin = users(:five)
  end
end

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
  def wait_for_ajax
    Timeout.timeout(Capybara.default_max_wait_time) do
      finished_all_ajax_requests?
    end
  end
  def finished_all_ajax_requests?
    loop do
      active = page.evaluate_script('jQuery.active')
      break if active == 0
    end
  end

  def teardown
#    Capybara.reset_sessions!
#    Capybara.use_default_driver
  end
end
