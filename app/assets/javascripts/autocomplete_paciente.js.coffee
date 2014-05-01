window.Helpers ||= {}

window.Helpers.AutocompletePaciente = {
  init_autocomplete: ->
    $(".identificacion").autocomplete
      minLength: 1
      source: "/clientes/autocomplete.json"
      select: (event, ui) ->
        $(".cliente_id").val ui.item.id
        $(".nombre").val ui.item.nombre
        $(".numero_de_identificacion").val ui.item.numero_de_identificacion
        $(".direccion").val ui.item.direccion
        $(".telefono").val ui.item.telefono
        $(".paciente_id").val ui.item.paciente_id
        $(".n_hclinica").text ui.item.n_hclinica
        $(".nombre_paciente").text ui.item.nombre
}

jQuery window.Helpers.AutocompletePaciente.init
$(document).on "ready page:load", window.Helpers.AutocompletePaciente.init_autocomplete
$(document).on "nested:fieldAdded", window.Helpers.AutocompletePaciente.init_autocomplete
