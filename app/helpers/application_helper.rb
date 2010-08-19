module ApplicationHelper
  def money(amount)
    ("#{amount % 1 == 0 ? '%d' : '%.2f'}&nbsp;&euro;" % amount).html_safe
  end
end
