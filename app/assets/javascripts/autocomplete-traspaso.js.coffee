window.Helpers ||= {}

window.Helpers.AutocompleteTraspaso = {
  init_autocomplete: ->
    $(".producto_traspaso").autocomplete
      minLength: 3
      source: "/productos/autocomplete.json"
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
        $this.closest(".productos_traspaso").find(".ingreso_producto_id").val ui.item.id_ingreso
        $this.closest(".productos_traspaso").find(".casa_comercial").text ui.item.casa_comercial
        $this.closest(".productos_traspaso").find(".precio_unitario").text ui.item.precio_venta
        $this.closest(".productos_traspaso").find(".hasiva").val ui.item.iva
        if ui.item.iva == true
          precio_venta = ui.item.precio_venta
          iva_producto = precio_venta * 0.12
          $this.closest(".productos_traspaso").find(".iva").text iva_producto.toFixed(2)
        else
          $this.closest(".productos_traspaso").find(".iva").val "0.0"
        window.Helpers.AutocompleteTraspaso.calcular_total_producto($this)
        window.Helpers.AutocompleteTraspaso.calcular_valores_factura()

    $(".cantidad_transferencia").on "input", ->
      $this = $(this)
      window.Helpers.AutocompleteTraspaso.calcular_total_producto($this)
      window.Helpers.AutocompleteTraspaso.calcular_valores_factura()

    $(".eliminar_item").on "click", ->
      $this = $(this)
      $this.closest(".productos_traspaso").remove()
      window.Helpers.AutocompleteTraspaso.calcular_valores_factura()

  calcular_total_producto: (componente) ->
    cantidad = componente.closest(".productos_traspaso").find(".cantidad_transferencia").val()
    valor_unitario = componente.closest(".productos_traspaso").find(".precio_unitario").text()
    valor_unitario = parseFloat(valor_unitario)
    hasiva = componente.closest(".productos_traspaso").find(".hasiva").val()
    if hasiva == "true"
      iva_producto = valor_unitario * 0.12
      componente.closest(".productos_traspaso").find(".iva").text((cantidad * iva_producto).toFixed(2))
    total = cantidad * valor_unitario
    componente.closest(".productos_traspaso").find(".total_producto").text(total.toFixed(2))
    
  calcular_valores_factura: ->
    sum = 0
    sum_iva = 0
    $(".total_producto").each ->
      sum += parseFloat($(this).text())
    $(".iva").each ->
      sum_iva += parseFloat($(this).text())
    total_final = (sum + sum_iva).toFixed(2)
    $(".total").text("$" + total_final);
}

jQuery window.Helpers.AutocompleteTraspaso.init
$(document).on "ready page:load", window.Helpers.AutocompleteTraspaso.init_autocomplete
$(document).on "nested:fieldAdded", window.Helpers.AutocompleteTraspaso.init_autocomplete
