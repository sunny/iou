$(document).ready(function() {

  // A Raphael.js pie chart
  Raphael.fn.pieChart = function(cx, cy, r, values, labels) {
    var paper = this,
        rad = Math.PI / 180,
        chart = this.set()

    function sector(cx, cy, r, startAngle, endAngle, params) {
      var x1 = cx + r * Math.cos(-startAngle * rad),
          x2 = cx + r * Math.cos(-endAngle * rad),
          y1 = cy + r * Math.sin(-startAngle * rad),
          y2 = cy + r * Math.sin(-endAngle * rad)
      return paper.path(["M", cx, cy, "L", x1, y1, "A", r, r, 0, +(endAngle - startAngle > 180), 0, x2, y2, "z"]).attr(params)
    }

    var angle = 0,
        total = 0,
        start = .8,
    process = function(j) {
      start = start > 0.9 ? 0 : start
      var value = values[j],
          angleplus = 360 * value / total,
          popangle = angle + (angleplus / 2),
          color = "hsb(" + start + ", 1, .7)",
          ms = 500,
          delta = 30,
          bcolor = "hsb(" + start + ", 1, 1)",
          p = sector(cx, cy, r, angle, angle + angleplus, {gradient: "90-" + bcolor + "-" + color, "stroke-width": 0}),
          txt = paper.text(cx + (r + delta + 55) * Math.cos(-popangle * rad), cy + (r + delta + 25) * Math.sin(-popangle * rad), labels[j]).attr({fill: bcolor, stroke: "none", opacity: 0, "font-family": 'Fontin-Sans, Arial', "font-size": "20px"})
      angle += angleplus
      chart.push(p)
      chart.push(txt)
      start += .1
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
      Raphael(table[0], 100, 100).pieChart(50, 50, 49, values, labels, "#fff")
  }


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

  // Overview pies
  if ($('#overview').length) {
    debtPie($('#you-owe'))
    debtPie($('#owe-you'))
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
