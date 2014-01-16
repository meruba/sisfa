window.Helpers ||= {}

window.Helpers.TooltipHelper = {
  init: ->
    $(".mostrar").each ->
      console.log $(this)
      $(this).insertBefore "<div class='tooltip' title='Mostrar'><div class='tooltip-inner'>"
      $(this).insertAfter "</div><div class='tooltip-arrow'></div></div>"
      $(this).tooltip()
}

jQuery window.Helpers.TooltipHelper.init
$(document).on "page:load", window.Helpers.TooltipHelper.init
