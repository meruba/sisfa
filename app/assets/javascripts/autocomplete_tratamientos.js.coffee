window.Helpers ||= {}

window.Helpers.AutocompleteTratamiento = {
  init_autocomplete: ->
    $(".tratamiento").autocomplete
      minLength: 3
      source: "/item_tratamientos/autocomplete.json"
      response: (event, ui) ->
        unless ui.content.length
          NoExiste =
            id: "vacio"
            label: "No existe: #{event.target.value}"
          ui.content.push NoExiste
        else
          $("#message").empty()
      select: (event, ui) ->
        $this = $(this)
        isRepeat = false
        $(".item_id").each ->
          if $(this).prev().is(":visible") != false
            if $(this).val() == ui.item.id.toString()
              alertify.log("Ya ingresaste este tratamiento");
              return isRepeat = true
        if !isRepeat
          $this.next(".item_id").val ui.item.id
        else
          $this.parents('.fields').remove()
}

jQuery window.Helpers.AutocompleteTratamiento.init
$(document).on "ready page:load", window.Helpers.AutocompleteTratamiento.init_autocomplete
$(document).on "nested:fieldAdded", window.Helpers.AutocompleteTratamiento.init_autocomplete
