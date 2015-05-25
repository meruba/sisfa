window.Helpers ||= {}

window.Helpers.AltaCertificado = {
  init: ->
    $(".alta-certificado").on "click", ->
      $this = $(this)
      id = $this.data('registro')
      estado = $this.data('estado')
      $.post("/asignar_horarios/"+id+"/dar_alta");
}

jQuery window.Helpers.AltaCertificado.init
$(document).on "ready page:load", window.Helpers.AltaCertificado.init
