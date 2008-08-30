# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def current_user
    controller.send(:current_user)
  end

  # Puts a span if the link is to the current page
  def link_or_span(name, options = {}, html_options = {})
    link_to_unless_current(name, options, html_options) do
      content_tag(:span, name, html_options)
    end
  end
end
