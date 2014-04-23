window.Helpers ||= {}

window.Helpers.AutocompleteHistoria = {
  init_autocomplete: ->
    $(".numero_de_hclinica").autocomplete
      minLength: 1
      source: "/historia_clinicas/autocomplete.json"
      select: (event, ui) ->
        $(".cliente_id").val ui.item.id
        $(".nombre").val ui.item.nombre
        $(".numero_de_identificacion").val ui.item.numero_de_identificacion
        $(".direccion").val ui.item.direccion
        $(".telefono").val ui.item.telefono
}

jQuery window.Helpers.AutocompleteHistoria.init
$(document).on "ready page:load", window.Helpers.AutocompleteHistoria.init_autocomplete
$(document).on "nested:fieldAdded", window.Helpers.AutocompleteHistoria.init_autocomplete
