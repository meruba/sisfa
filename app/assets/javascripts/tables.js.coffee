# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
init_datatables = ->
	$('.data-table').dataTable
    sDom: "<'row'<'col-xs-6'T><'col-xs-6'f>r>t<'row'<'col-xs-6'i><'col-xs-6'p>>"
    oLanguage:
      sUrl: "datatables.spanish.txt"
    aoColumnDefs: [
    	bSortable: false
    	aTargets: [-1]
    ]
    bProcessing: true
    bServerSide: true
    sAjaxSource: $(".data-table").data('source')


jQuery ->
  init_datatables()
$(document).on "page:load", init_datatables

window.Helpers.init_datatables = init_datatables
