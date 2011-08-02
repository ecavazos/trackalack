module CapybaraHelper

  def wait_for_ajax! wait_time=Capybara.default_wait_time
    require_javascript_support!
    page.wait_until wait_time do
      pending_xhr_count == 0
    end
  end

  def pending_xhr_count
    require_javascript_support!
    page.evaluate_script 'jQuery.active'
  end

  def require_javascript_support!
    raise 'this helper requires javascript support to be enabled' if Capybara.current_driver == :rack_test
  end
end

RSpec.configure do |config|
  config.include CapybaraHelper, :type => :request
end
