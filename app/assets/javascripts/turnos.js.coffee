TurnosAtendidos= {
  init: ->
    $("#turnos-hoy .sortable-list").sortable
      connectWith: "#turnos-hoy .sortable-list"
      containment: "#turnos"
      receive: (event, ui) ->
        $this = ui.item
        $turno = $this.children(":first")
        estado = $turno.data("atendido")
        id = $this.data("id")
        $icon = $this.find(".fa")
        $.get "/turnos/#{id}/atendido"
        $icon.fadeOut 500, ->
          if estado == true
            $turno.data("atendido",false)
            $icon.removeClass("fa-dot-circle-o").addClass("fa-circle-o").css "color", "#CE5C5B"
            alertify.log "Paciente no atendido"
          else
            $turno.data("atendido",true)
            $icon.removeClass("fa-circle-o").addClass("fa-dot-circle-o").css "color", "#4bbc65"
            alertify.success "Paciente atendido"
        $icon.fadeIn 500, ->
}

$(document).on "ready page:load", ->
  TurnosAtendidos.init()