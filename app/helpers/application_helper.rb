module ApplicationHelper
  def link_to_person(person, params = {})
    link_to person.try(:name), person
  end

  def money(amount)
    amount = amount.amount if amount.respond_to?(:amount)
    amount_str = (amount % 1 == 0 ? '%d' : '%.2f') % amount
    ("%s&nbsp;%s" % [amount_str, DEFAULT_CURRENCY_SYMBOL]).html_safe
  end
end
