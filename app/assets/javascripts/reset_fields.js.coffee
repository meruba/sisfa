window.Helpers ||= {}

window.Helpers.ResetFields = {
  init: ->
  	$(".reset-fields").on "click", ->
    	$id = $('table').attr('id')
    	$("table#"+$id+" > tbody > tr").not(':first').not(':last').remove()
    	$(":input", "#form-"+$id).removeAttr("checked").removeAttr("selected").not(":button, :submit, :reset, :radio, :checkbox").val ""
    	$(".subtotal_12").text("0.00")
    	$(".subtotal_0").text("0.00")
    	$(".iva_factura").text("0.00")
    	$(".total_factura").text("0.00")
    	$(".precio_unitario").text("0.00")
    	$(".iva").text("0.00")
    	$(".total_producto").text("0.00")
    	$(".total").text("0.00")
}
jQuery window.Helpers.ResetFields.init
$(document).on "page:load", window.Helpers.ResetFields.init
