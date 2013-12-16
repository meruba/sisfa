init_autocomplete = ->
  $("#numero_de_identificacion").autocomplete
    minLength: 3
    source: "/clientes/autocomplete.json"
    select: (event, ui) ->
      $("#nombre").val ui.item.nombre
      $("#direccion").val ui.item.direccion
      $("#telefono").val ui.item.telefono

  $("#producto").autocomplete
    minLength: 3
    source: "/productos.json"
    select: (event, ui) ->
      suma = $("#factura_item_factura_cantidad").val() * ui.item.precio
      $("#factura_item_factura_total").val suma
      $("#factura_item_factura_valor_unitario").val ui.item.precio
      $("#codigo").val ui.item.codigo

jQuery ->
  init_autocomplete()
$(document).on "page:load", init_autocomplete
