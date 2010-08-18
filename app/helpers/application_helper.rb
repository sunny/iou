module ApplicationHelper
  def money(amount)
    "%d&nbsp;&euro;" if amount % 1 === 0
    "%.2f&nbsp;&euro;" % amount
  end
end
