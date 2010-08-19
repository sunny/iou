module ApplicationHelper
  def link_to_person(person, params = {})
    link_to person.name, person
  end

  def money(amount)
    amount = amount.amount if amount.respond_to?(:amount)
    amount_str = (amount % 1 == 0 ? '%d' : '%.2f') % amount
    ("%s&nbsp;&euro;" % amount_str).html_safe
  end
end
