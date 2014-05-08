window.Helpers ||= {}

window.Helpers.AutocompleteDoctor = {
  init_autocomplete: ->
    $(".doctor_autocomplete").autocomplete
      minLength: 2
      source: "/doctors/autocomplete.json"
      select: (event, ui) ->
        $(".doctor_id").val ui.item.id
        $(".nombre").val ui.item.nombre
}

jQuery window.Helpers.AutocompleteDoctor.init
$(document).on "ready page:load", window.Helpers.AutocompleteDoctor.init_autocomplete
$(document).on "nested:fieldAdded", window.Helpers.AutocompleteDoctor.init_autocomplete

