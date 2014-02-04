window.Helpers ||= {}

window.Helpers.Datepicker = {
	init_datepicker: ->
	  $(".datepicker").datepicker({
	    format: 'yyyy-mm-dd',
	    language: "es",
	    autoclose: true
	  })
}

jQuery window.Helpers.Datepicker.init_datepicker
$(document).on "page:load", window.Helpers.Datepicker.init_datepicker
$ ->
  $("#myModal").on "shown.bs.modal", ->
    jQuery window.Helpers.Datepicker.init_datepicker

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