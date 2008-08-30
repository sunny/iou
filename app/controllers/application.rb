# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '0059af40e0f763d98c43bba4779a5171'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  filter_parameter_logging :password

  private

  def verify_access
    authenticate_or_request_with_http_basic("IOU") do |username, password|
      @current_user = User.authenticate(username, password)
    end
  end

  # Return User currently logged in via HTTP Auth
  def current_user
    if @current_user.nil?
      authenticate_with_http_basic do |username, password|
        @current_user = User.authenticate(username, password)
      end
    end
    @current_user ||= false
  end
end
