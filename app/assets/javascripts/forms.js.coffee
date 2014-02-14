window.Helpers ||= {}

window.Helpers.FormNotSubmited = {
    
  loadVariable: ->
    window.formulario = $(".new_factura").serialize()

  changeValue: ->
    window.submited = true
  init: ->
    if $(".new_factura").size() > 0 and window.submited != true
      unless $(".new_factura").serialize() == window.formulario
        unless confirm("Aún no has guardado los cambios del formulario. ¿Estás seguro?")
          false
}
$(document).on 'page:ready page:load' , window.Helpers.FormNotSubmited.loadVariable
$(document).on 'submit', '.new_factura', window.Helpers.FormNotSubmited.changeValue
$(document).on 'page:before-change' , window.Helpers.FormNotSubmited.init
