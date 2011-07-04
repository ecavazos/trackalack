Capybara.configure do |config|
  config.default_selector  = :css
  config.default_driver    = :rack_test
  config.javascript_driver = :selenium
end

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

