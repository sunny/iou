$(document).ready(function() {

  // Include a pie chart for a table of debts
  function debtPie(table) {
    var values = [],
        labels = [],
        hrefs = []
    table.find('tr').each(function () {
      var a = $("th a", this),
          value = parseFloat($("td", this).text())
      labels.push(value + " EUR " + a.text())
      values.push(value)
      hrefs.push(a.attr('href'))
    })
    if (values.length > 1) {
      var r = Raphael(table[0], 300, 120),
          pie = r.g.piechart(60, 60, 50, values, {legend: labels, legendpos: "east", href: hrefs, colors:['#8B008B']})
      pie.hover(function () {
        this.sector.stop()
        this.sector.scale(1.1, 1.1, this.cx, this.cy)
        if (this.label) {
          this.label[0].stop()
          this.label[0].scale(1.5)
          this.label[1].attr({"font-weight": 800})
        }
      }, function () {
        this.sector.animate({scale: [1, 1, this.cx, this.cy]}, 500, "bounce")
        if (this.label) {
          this.label[0].animate({scale: 1}, 500, "bounce")
          this.label[1].attr({"font-weight": 400})
        }
      })

    }
  }


  // Text translations by language
  var translations = {
    en: {
      bill: {
        with_amount: {
          with_user: {
            bill: {
              you_payed: "%person owes you %money",
              payed_you: "You owe %person %money"
            },
            payment: {
              you_payed: "You payed back %money to %person",
              payed_you: "%person payed you back %money"
            }
          },
          without_user: {
            bill: {
              you_payed: "Someone owes you %money",
              payed_you: "You owe someone %money"
            },
            payment: {
              you_payed: "You gave back %money to someone",
              payed_you: "Someone payed you back %money"
            }
          }
        },
        without_amount: {
          with_user: {
            bill: {
              you_payed: "%person owes you money",
              payed_you: "You owe money to %person"
            },
            payment: {
              you_payed: "You payed back %person",
              payed_you: "%person payed you back"
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

  // Autocompleters
  $('input[autocomplete_url]').each(function(i){
    $(this).autocomplete({ source: $(this).attr('autocomplete_url') });
  });

  // Overview pies
  if ($('#overview').length) {
    debtPie($('#you_owe'))
    debtPie($('#owes_you'))
  }

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
          currencyValue = amount_input.attr('data-currency-symbol'),
          txtAmount = amount + ' ' + currencyValue,
          user = friend_input.val(),
          text = translations.en.bill
            [amount > 0 ? 'with_amount' : 'without_amount']
            [user ? 'with_user' : 'without_user']
            [type.toLowerCase()]

      bill_tabs.removeClass('checked')
      checked.parent('label').addClass('checked')
      you_payed_text.text(text.you_payed.replace(/%money/, txtAmount).replace(/%person/, user))
      payed_you_text.text(text.payed_you.replace(/%money/, txtAmount).replace(/%person/, user))
    }

    // Add events on bill form
    amount_input.blur(bill_form_update)
    friend_input.blur(bill_form_update)
    bill_form.click(bill_form_update)
    bill_form_update()
  }
})
