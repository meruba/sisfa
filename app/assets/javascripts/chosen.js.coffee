window.Helpers ||= {}

window.Helpers.ChosenHelper = {
  init: ->
    $(".select-servicio").chosen()
}

jQuery window.Helpers.ChosenHelper.init
$(document).on "page:load", window.Helpers.ChosenHelper.init