class ApplicationController < ActionController::Base

  # TODO: fix this in Rails 3.1
  # Ensure that application helper is the only helper loaded by default.
  clear_helpers
  helper :application

  protect_from_forgery
  before_filter :authenticate_user!
  layout :layout_picker

  private

    def layout_picker
      sign_in? ? 'sign_in' : 'application'
    end

    def sign_in?
      devise_controller? &&
      controller_name == 'sessions' &&
      action_name == 'new'
    end
end
