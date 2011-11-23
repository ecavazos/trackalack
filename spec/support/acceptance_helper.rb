module AcceptanceHelper
  def sign_in( user = nil )
    user = user || User.gen
    visit new_user_session_path
    fill_in 'user_email',    :with => user.email
    fill_in 'user_password', :with => user.password
    click_button 'Sign in'
    user
  end

  def with_timestamping_disabled(*klasses)
    if block_given?
      klasses.delete_if { |klass| !klass.record_timestamps }
      klasses.each { |klass| klass.record_timestamps = false }
      begin
        yield
      ensure
        klasses.each { |klass| klass.record_timestamps = true }
      end
    end
  end
end

RSpec.configure do |config|
  config.include AcceptanceHelper, :type => :request
end
