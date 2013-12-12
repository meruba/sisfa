init_datepicker = ->
  $(".datepicker").datepicker({
    format: 'yyyy-mm-dd'
  })
null

jQuery init_datepicker
$(document).on "page:load", init_datepicker

$ ->
  $("#myModal").on "shown.bs.modal", ->
    jQuery init_datepicker
