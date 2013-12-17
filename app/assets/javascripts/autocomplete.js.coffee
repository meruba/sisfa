init_autocomplete = ->
  $(".numero_de_identificacion").autocomplete
    minLength: 3
    source: "/clientes/autocomplete.json"
    select: (event, ui) ->
      $(".nombre").val ui.item.nombre
      $(".direccion").val ui.item.direccion
      $(".telefono").val ui.item.telefono

  $(".autocomplete_producto").autocomplete
    minLength: 3
    source: "/productos/autocomplete.json"
    select: (event, ui) ->
      suma = $(".cantidad").val() * ui.item.precio_a
      $(".total").val suma
      $(".valor_unitario").val ui.item.precio_a
      $(".codigo").val ui.item.codigo

jQuery ->
  init_autocomplete()
$(document).on "page:load", init_autocomplete
$(document).on "nested:fieldAdded", init_autocomplete
