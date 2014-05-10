window.Helpers ||= {}

window.Helpers.ChosenHelper = {
  init: ->
    $(".select-servicio").chosen()
  
  init_whit_modal: ->
  	$("#myModal").on "shown.bs.modal", ->
  		$(".select-egreso", this).chosen("destroy").chosen()
}

jQuery window.Helpers.ChosenHelper.init
$(document).on "page:load", window.Helpers.ChosenHelper.init
$(document).on "page:load", window.Helpers.ChosenHelper.init_whit_modal