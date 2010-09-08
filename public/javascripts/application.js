$(document).ready(function() {

  // A Raphael.js pie chart
  Raphael.fn.pieChart = function(cx, cy, r, values, labels) {
    var paper = this,
        rad = Math.PI / 180,
        chart = this.set(),
        colors = [0.8, 0.1, 0.3, 0.5, 0.9, 0.6, 0.2, 0.4, 0.7, 0],
        angle = 0,
        total = 0,
        start = 0

    function sector(cx, cy, r, startAngle, endAngle, params) {
      if (startAngle == 0 && endAngle == 360)
        return paper.circle(cx, cy, r).attr(params)
      var x1 = cx + r * Math.cos(-startAngle * rad),
          x2 = cx + r * Math.cos(-endAngle * rad),
          y1 = cy + r * Math.sin(-startAngle * rad),
          y2 = cy + r * Math.sin(-endAngle * rad)
      return paper.path(["M", cx, cy, "L", x1, y1, "A", r, r, 0, +(endAngle - startAngle > 180), 0, x2, y2, "z"]).attr(params)
    }

    function process(j) {
      var value = values[j],
          ratio = value / total,
          label = labels[j] + ' ' + Math.floor(ratio*100) + '%',
          angleplus = 360 * ratio,
          popangle = angle + (angleplus / 2),
          hue = colors[start],
          color = "hsb(" + hue + ", 1, .7)",
          ms = 500,
          delta = 20,
          bcolor = "hsb(" + hue + ", 1, 1)",
          tx = cx + (r + delta + 10) * Math.cos(-popangle * rad),
          ty = cy + (r + delta +  0) * Math.sin(-popangle * rad),
          p = sector(cx, cy, r, angle, angle + angleplus, {gradient: "90-" + bcolor + "-" + color, "stroke-width": 1, stroke: 'white'}),
          txt = paper.text(tx, ty, label).attr({"font-family": 'Helvetica, sans-serif', "font-size": "9px"})

      angle += angleplus
      chart.push(p)
      chart.push(txt)
      start++
    }

    for (var i = 0, ii = values.length; i < ii; i++)
      total += values[i]

    for (var i = 0; i < ii; i++)
      process(i)

    return chart
  };

  // Include a pie chart for a table of debts
  function debtPie(table) {
    var values = [],
        labels = []
    table.find('tr').each(function () {
      labels.push($("th a", this).text())
      values.push(parseFloat($("td", this).text()))
    })


    if (!values.empty && !labels.empty)
      Raphael(table[0], 300, 150).pieChart(300/2, 150/2, 49, values, labels, "#fff")
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
