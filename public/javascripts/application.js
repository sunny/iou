$(window).load(function() {
  // Text translations by language
  var translations = {
    en: {
      bill: {
        with_amount: {
          with_user: {
            bill: {
              you_payed: "%s owes you %f €",
              payed_you: "You owe %s %f €"
            },
            payment: {
              you_payed: "You payed back %f € to %s",
              payed_you: "%s payed you back %f €"
            }
          },
          without_user: {
            bill: {
              you_payed: "Someone owes you %f €",
              payed_you: "You owe someone %f €"
            },
            payment: {
              you_payed: "You gave back %f € to someone",
              payed_you: "Someone payed you back %f €"
            }
          }
        },
        without_amount: {
          with_user: {
            bill: {
              you_payed: "%s owes you money",
              payed_you: "You owe money to %s"
            },
            payment: {
              you_payed: "You payed back %s",
              payed_you: "%s payed you back"
            }
          },
          without_user: {
            bill: {
              you_payed: "Someone owes you money",
              payed_you: "You owe someone money"
            },
            payment: {
              you_payed: "You payed back someone",
              payed_you: "Someone payed you back"
            }
          }
        }
      }
    }
  }


  $('body').addClass('js')


  // Bill form
  var bill_form = $('.new_bill,.edit_bill')
  if (bill_form.length) {
    var bill_tabs = $('#bill_tabs label'),
        friend_input = $('#friend_name'),
        amount_input = $('#bill_amount'),
        you_payed_text = $('#you_payed_true span'),
        payed_you_text = $('#you_payed_false span')

    // Returns the bill amount with two decimals
    function bill_amount() {
      var num = parseFloat(amount_input.val())
      return num > 0 ? Math.round(num*100)/100 : 0
    }

    // Updates the tab selection and the payment text
    function bill_form_update() {
      var checked = bill_tabs.find(':checked'),
          type = checked.attr('value'),
          amount = bill_amount(),
          user = friend_input.val(),
          text = translations.en.bill
            [amount > 0 ? 'with_amount' : 'without_amount']
            [user ? 'with_user' : 'without_user']
            [type.toLowerCase()]

      bill_tabs.removeClass('checked')
      checked.parent('label').addClass('checked')
      you_payed_text.text(text.you_payed.replace(/%f/, amount).replace(/%s/, user))
      payed_you_text.text(text.payed_you.replace(/%f/, amount).replace(/%s/, user))
    }

    // Add events on bill form
    amount_input.blur(bill_form_update)
    friend_input.blur(bill_form_update)
    bill_form.click(bill_form_update)
    bill_form_update()
  }
})
