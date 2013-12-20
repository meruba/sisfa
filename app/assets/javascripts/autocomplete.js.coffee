init_autocomplete = ->
  $(".numero_de_identificacion").autocomplete
    minLength: 3
    source: "/clientes/autocomplete.json"
    select: (event, ui) ->
      $(".cliente_id").val ui.item.id
      $(".nombre").val ui.item.nombre
      $(".direccion").val ui.item.direccion
      $(".telefono").val ui.item.telefono

  $(".autocomplete_producto").autocomplete
    minLength: 3
    source: "/productos/autocomplete.json"
    select: (event, ui) ->
      $this = $(this)
      $this.closest(".fields").find("td:nth-child(3)").find(".producto_id").val ui.item.id
      $this.closest(".fields").find("td:nth-child(1)").find(".codigo").val ui.item.codigo
      $this.closest(".fields").find("td:nth-child(4)").find(".valor_unitario").val ui.item.precio_a
      cantidad = $this.closest(".fields").find("td:nth-child(3)").find(".cantidad").val()
      valor_unitario = $this.closest(".fields").find("td:nth-child(4)").find(".valor_unitario").val()
      total = $this.closest(".fields").find("td:nth-child(7)").find(".total")
      total.val(cantidad * valor_unitario)
      calcular_valores()

  $(".cantidad").on "input", ->
    $this = $(this)
    cantidad = $this.val()
    valor_unitario = $this.closest(".fields").find("td:nth-child(4)").find(".valor_unitario").val()
    total = $this.closest(".fields").find("td:nth-child(7)").find(".total")
    total.val(cantidad * valor_unitario)
    calcular_valores()

calcular_total = ->

calcular_valores = ->
  sum = 0
  $(".total").each ->
    sum += parseFloat($(this).val())
  $(".subtotal_0").val sum
  $(".subtotal_12").val sum
  $(".descuento_factura").val 0
  $(".iva_factura").val((sum*0.12).toFixed(2));
  $(".total_factura").val((sum*0.12+sum).toFixed(2));

jQuery ->
  init_autocomplete()
$(document).on "page:load", init_autocomplete
$(document).on "nested:fieldAdded", init_autocomplete
$(document).on "nested:fieldRemoved", init_autocomplete