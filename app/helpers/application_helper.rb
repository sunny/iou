# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # Return User currently logged in via HTTP Auth
  def current_user
    if @current_user.nil?
      controller.authenticate_with_http_basic do |username, password|
        @current_user = User.authenticate(username, password)
      end
    end
    @current_user ||= false
  end

  # Puts a span if the link is to the current page
  def link_or_span(name, options = {}, html_options = {})
    link_to_unless_current(name, options, html_options) do
      content_tag(:span, name, html_options)
    end
  end
end
