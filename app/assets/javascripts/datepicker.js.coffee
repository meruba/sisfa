init_datepicker = ->
  $(".datepicker").datepicker({
    format: 'yyyy-mm-dd',
    language: "es"
  })
null

jQuery init_datepicker
$(document).on "page:load", init_datepicker
$ ->
  $("#myModal").on "shown.bs.modal", ->
    jQuery init_datepicker

# $ ->
#   $("#myModal").on "shown.bs.modal", ->
#     jQuery init_datepicker

# $.fn.extend {
#   integrateDatepicker: (selector)->
#     selector = selector || '.datepicker'
#     $(@).find(selector).datepicker()
# }
# $(document).ready () ->
#   $('body').integrateDatepicker()