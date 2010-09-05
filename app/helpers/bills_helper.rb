module BillsHelper
  def bill_resume(bill)
    sentence = case bill.bill_type
      when "Payment"
        @you_payed ? "You payed back %s" : "%s payed you back"
      when "Bill"
        @you_payed ? "%s owes you" : "You owe %s"
      when "Shared"
        return "Shared bill"
    end
    (html_escape(sentence) % link_to_person(@friend)).html_safe
  end
end


