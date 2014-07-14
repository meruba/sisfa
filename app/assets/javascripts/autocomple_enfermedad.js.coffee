window.Helpers ||= {}

window.Helpers.AutocompleteEnfermedad = {
  init_autocomplete: ->
	  $(".enfermedad").autocomplete
	    minLength: 1
	    source: "/enfermedads/autocomplete.json"
	    select: (event, ui) ->
	      $this = $(this)
	      $(this).prev().prev().find(".codigo_cie").text ui.item.codigo
	      $(this).next().val ui.item.codigo
}

jQuery window.Helpers.AutocompleteEnfermedad.init
$(document).on "ready page:load", window.Helpers.AutocompleteEnfermedad.init_autocomplete
