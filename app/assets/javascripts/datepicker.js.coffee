init_datepicker = ->
  $('.datepicker').datetimepicker
    pickTime: false

jQuery ->
  init_datepicker()
$(document).on "page:load", init_datepicker()
$ ->
  $("#myModal").on "shown.bs.modal", ->
    init_datepicker()



window.Helpers.init_datepicker = init_datepicker
