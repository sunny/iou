ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  title = instance.error_message
  title = '* ' + title.join("\n* ") if title.respond_to?(:join)
  "<span class=\"error_field\" title=\"#{title}\">#{html_tag}</span>"
end

