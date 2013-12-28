window.Helpers ||= {}

window.Helpers.DateHelper = {
  init: ->
    $(".fecha").each ->
      $(this).text(moment().lang("es").format("LLL"))
    $(".mes").each ->
      $(this).text(moment().lang("es").format("MMMM"))
    $(".fecha_sin_hora").each ->
      $(this).text(moment().lang("es").format("LL"))
}

jQuery window.Helpers.DateHelper.init
$(document).on "page:load", window.Helpers.DateHelper.init
