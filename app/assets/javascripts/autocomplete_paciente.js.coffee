window.Helpers ||= {}

window.Helpers.AutocompletePaciente = {
  init_autocomplete: ->
    $(".identificacion").autocomplete
      minLength: 1
      source: "/pacientes/autocomplete.json"
      response: (event, ui) ->
        unless ui.content.length
          NoExiste =
            id: "vacio"
            label: "No esta registrado: #{event.target.value}"
          ui.content.push NoExiste
        else
          $("#message").empty()
      select: (event, ui) ->
        $(".cliente_id").val ui.item.cliente_id
        $(".nombre").val ui.item.nombre
        $(".paciente_id").val ui.item.id
        $(".n_hclinica").text ui.item.n_hclinica
        $(".nombre_paciente").text ui.item.nombre
}

jQuery window.Helpers.AutocompletePaciente.init
$(document).on "ready page:load", window.Helpers.AutocompletePaciente.init_autocomplete
$(document).on "nested:fieldAdded", window.Helpers.AutocompletePaciente.init_autocomplete
