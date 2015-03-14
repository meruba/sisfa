window.Helpers ||= {}

window.Helpers.AutocompletePacienteRegistroHorario = {
  init_autocomplete: ->
    $(".paciente-fisitria").autocomplete
      minLength: 1
      source: "/asignar_horarios/autocomplete.json"
      response: (event, ui) ->
        unless ui.content.length
          NoExiste =
            id: "vacio"
            label: "No existe: #{event.target.value}"
          ui.content.push NoExiste
        else
          $("#message").empty()
      select: (event, ui) ->
        $(".paciente_as_id").val ui.item.id
}

jQuery window.Helpers.AutocompletePacienteRegistroHorario.init
$(document).on "ready page:load", window.Helpers.AutocompletePacienteRegistroHorario.init_autocomplete
$(document).on "nested:fieldAdded", window.Helpers.AutocompletePacienteRegistroHorario.init_autocomplete

