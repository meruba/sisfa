window.Helpers ||= {}

window.Helpers.Datepicker = {
	init_datepicker: ->
	  $(".datepicker").datepicker({
	    format: 'yyyy-mm-dd',
	    language: "es",
	    autoclose: true
	  })

	init_datepicker_month: ->
	  $(".datepicker_month").datepicker({
	    format: 'yyyy-mm-dd',
    	minViewMode: "months",
	    language: "es",
	    autoclose: true
	  })
}

jQuery window.Helpers.Datepicker.init_datepicker
$(document).on "page:load", window.Helpers.Datepicker.init_datepicker
$(document).on "page:load", window.Helpers.Datepicker.init_datepicker_month
$ ->
  $("#myModal").on "shown.bs.modal", ->
    jQuery window.Helpers.Datepicker.init_datepicker
    jQuery window.Helpers.Datepicker.init_datepicker_month
