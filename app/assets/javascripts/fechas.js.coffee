window.Helpers ||= {}

window.Helpers.DateHelper = {
  init: ->
    $(".fecha").each ->
      $(this).text(moment().lang("es").format("LLL"))

}

jQuery window.Helpers.DateHelper.init
$(document).on "page:load", window.Helpers.DateHelper.init
