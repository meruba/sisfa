window.Helpers ||= {}

window.Helpers.DateHelper = {
  init: ->
    $(".fecha").each ->
      $(this).text(moment().lang("es").format("LLL"))
    $(".mes").each ->
      $(this).text(moment().lang("es").format("MMMM").toUpperCase())
    $(".fecha_sin_hora").each ->
      $(this).text(moment().lang("es").format("LL"))
    $(".año").each ->
      $(this).text(moment().lang("es").format("YYYY"))
}

jQuery window.Helpers.DateHelper.init
$(document).on "page:load", window.Helpers.DateHelper.init
