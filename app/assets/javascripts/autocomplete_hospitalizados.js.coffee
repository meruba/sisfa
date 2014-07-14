window.Helpers ||= {}

window.Helpers.AutocompletePaciente = {
  init_autocomplete: ->
    $(".paciente-hospitalizado").autocomplete
      minLength: 1
      source: "/hospitalizacion_registros/autocomplete.json"
      response: (event, ui) ->
        unless ui.content.length
          NoExiste =
            id: "vacio"
            label: "No existe: #{event.target.value}"
          ui.content.push NoExiste
        else
          $("#message").empty()
      select: (event, ui) ->
        $(".hospitalizacion_registro_id").val ui.item.id
}

jQuery window.Helpers.AutocompletePaciente.init
$(document).on "ready page:load", window.Helpers.AutocompletePaciente.init_autocomplete
$(document).on "nested:fieldAdded", window.Helpers.AutocompletePaciente.init_autocomplete
