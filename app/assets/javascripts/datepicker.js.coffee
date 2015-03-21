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
  init_datepicker_not_weekend: ->
    $('.datepicker-not-weekend').datepicker({
      daysOfWeekDisabled: [0,6],
      format: 'yyyy-mm-dd'
    });
}

jQuery window.Helpers.Datepicker.init_datepicker
$(document).on "page:load", window.Helpers.Datepicker.init_datepicker
$(document).on "nested:fieldAdded", window.Helpers.Datepicker.init_datepicker

jQuery window.Helpers.Datepicker.init_datepicker_month
$(document).on "page:load", window.Helpers.Datepicker.init_datepicker_month
$(document).on "nested:fieldAdded", window.Helpers.Datepicker.init_datepicker_month

jQuery window.Helpers.Datepicker.init_datepicker_not_weekend
$(document).on "page:load", window.Helpers.Datepicker.init_datepicker_not_weekend
$(document).on "nested:fieldAdded", window.Helpers.Datepicker.init_datepicker_not_weekend

$ ->
  $("#myModal").on "shown.bs.modal", ->
    jQuery window.Helpers.Datepicker.init_datepicker
    jQuery window.Helpers.Datepicker.init_datepicker_month
   $("#myModallg").on "shown.bs.modal", ->
    jQuery window.Helpers.Datepicker.init_datepicker
