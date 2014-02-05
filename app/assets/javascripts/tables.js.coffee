init_datatables = ->
  $('.data-table').each ->
    $(this).dataTable
      sDom: "<'row'<'col-xs-6'T><'col-xs-6'f>r>t<'row'<'col-xs-6'i><'col-xs-6'p>>"
      oLanguage:
        sUrl: "/datatables.spanish.txt"
      bProcessing: true
      bServerSide: true
      bJQueryUI: true,
      sAjaxSource: $(this).data('source')
      aoColumnDefs: [
        bSortable: false
        aTargets: [-1]
      ]
      fnInitComplete: (oSettings, json) ->
        jQuery window.Helpers.TooltipHelper.init
  $('.data-table-without-json').each ->
    $(this).dataTable
      sDom: "<'row'<'col-xs-6'T><'col-xs-6'f>r>t<'row'<'col-xs-6'i><'col-xs-6'p>>"
      oLanguage:
        sUrl: "/datatables.spanish.txt"
      bJQueryUI: true,

jQuery ->
  init_datatables()
$(document).on "page:load", init_datatables

window.Helpers.init_datatables = init_datatables
