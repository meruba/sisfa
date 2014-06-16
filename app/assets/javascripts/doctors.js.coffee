window.Helpers ||= {}

window.Helpers.AutocompleteDoctor = {
  init_autocomplete: ->
    $(".doctor_autocomplete").autocomplete
      minLength: 2
      source: "/doctors/autocomplete.json"
      response: (event, ui) ->
        unless ui.content.length
          NoExiste =
            id: "vacio"
            label: "No esta disponible el Dr(a): #{event.target.value}"
          ui.content.push NoExiste
        else
          $("#message").empty()
      select: (event, ui) ->
        $(".doctor_id").val ui.item.id
        $(".doctor_nombre").val ui.item.nombre
}

jQuery window.Helpers.AutocompleteDoctor.init
$(document).on "ready page:load", window.Helpers.AutocompleteDoctor.init_autocomplete
$(document).on "nested:fieldAdded", window.Helpers.AutocompleteDoctor.init_autocomplete
