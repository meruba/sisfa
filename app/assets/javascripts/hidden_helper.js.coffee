window.Helpers ||= {}

window.Helpers.HiddenContent = {
  init: ->
  	if $(".Whos").text() != "Administrador"
  		$(".only-admin").remove()
}

jQuery window.Helpers.HiddenContent.init
$(document).on "page:load", window.Helpers.HiddenContent.init