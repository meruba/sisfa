window.Helpers ||= {}

window.Helpers.AutocompleteHelper = {
  init_autocomplete: ->
    $(".numero_de_identificacion").autocomplete
      minLength: 3
      source: "/clientes/autocomplete.json"
      response: (event, ui) ->
        unless ui.content.length
          addNewCliente =
            id: "vacio"
            label:  "Agregar: #{event.target.value}"
            cedula: event.target.value
          ui.content.push addNewCliente
        else
          $("#message").empty()
      select: (event, ui) ->
        if ui.item.id == "vacio"
          $.getScript "/clientes/new"
          $('#myModal').modal
            remote: ""
          $('#myModal').on "shown.bs.modal", ->
            $('#cliente_numero_de_identificacion').val(ui.item.cedula)
        else
          $(".cliente_id").val ui.item.id
          $(".nombre").val ui.item.nombre
          $(".direccion").val ui.item.direccion
          $(".telefono").val ui.item.telefono

    $(".autocomplete_producto").autocomplete
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
        $this.closest(".fields").find("td:nth-child(2)").find(".ingreso_producto_id").val ui.item.id_ingreso
        $this.closest(".fields").find("td:nth-child(3)").text ui.item.precio_venta
        $this.closest(".fields").find("td:nth-child(7)").find(".hasiva").val ui.item.iva
        if ui.item.iva == true
          precio_venta = ui.item.precio_venta
          iva_producto = precio_venta * 0.12
          $this.closest(".fields").find("td:nth-child(4)").text(iva_producto.toFixed(2))
        $this.closest(".fields").find("td:nth-child(4)").text("0.0")
        window.Helpers.AutocompleteHelper.calcular_total_producto($this)
        window.Helpers.AutocompleteHelper.calcular_valores_factura()

    $(".cantidad").on "input", ->
      $this = $(this)
      window.Helpers.AutocompleteHelper.calcular_total_producto($this)
      window.Helpers.AutocompleteHelper.calcular_valores_factura()

  calcular_total_producto: (componente) ->
    cantidad = componente.closest(".fields").find("td:nth-child(2)").find(".cantidad").val()
    valor_unitario = componente.closest(".fields").find("td:nth-child(3)").text()
    valor_unitario = parseFloat(valor_unitario)
    hasiva = componente.closest(".fields").find("td:nth-child(7)").find(".hasiva").val()
    if hasiva == "true"
      iva_producto = (valor_unitario * 0.12).toFixed(2)
      componente.closest(".fields").find("td:nth-child(4)").text((cantidad * iva_producto).toFixed(2))
    total_produto = (cantidad * valor_unitario).toFixed(2)
    componente.closest(".fields").find("td:nth-child(5)").text(total_produto)

  calcular_valores_factura: ->
    sum = 0
    sum_iva = 0
    sum_12 = 0
    sum_0 = 0
    $(".total_item").each ->
      sum += parseFloat($(this).text())
    $(".iva").each ->
      sum_iva += parseFloat($(this).text())
      if $(this).text() != "0.0"
        sum_12 += parseFloat($(this).closest(".fields").find("td:nth-child(5)").text())
      else
        sum_0 += parseFloat($(this).closest(".fields").find("td:nth-child(5)").text())
    $(".subtotal_0").text sum_0.toFixed(2)
    $(".subtotal_12").text sum_12.toFixed(2)
    $(".descuento_factura").text 0
    $(".iva_factura").text(sum_iva.toFixed(2));
    $(".total_factura").text((sum+sum_iva).toFixed(2));

  init_autocompleteProveedor: ->
    $(".numero_de_identificacion_proveedor").autocomplete
      minLength: 3
      source: "/proveedors/autocomplete.json"
      response: (event, ui) ->
        unless ui.content.length
          addNewProveedor =
            id: "vacio"
            label:  "Agregar: #{event.target.value}"
            cedula: event.target.value
          ui.content.push addNewProveedor
        else
          $("#message").empty()
      select: (event, ui) ->
        if ui.item.id == "vacio"
          $.getScript "/proveedors/new"
          $('#myModal').modal
            remote: ""
          $('#myModal').on "shown.bs.modal", ->
            $('#proveedor_numero_de_identificacion').val(ui.item.cedula)
        else
          $(".proveedor_id").val ui.item.id
          $(".nombre").val ui.item.nombre_o_razon_social
          $(".direccion").val ui.item.direccion
          $(".telefono").val ui.item.telefono
}

jQuery window.Helpers.AutocompleteHelper.init
$(document).on "ready page:load", window.Helpers.AutocompleteHelper.init_autocomplete
$(document).on "ready page:load", window.Helpers.AutocompleteHelper.init_autocompleteProveedor

$(document).on "nested:fieldAdded", window.Helpers.AutocompleteHelper.init_autocomplete
$(document).on "nested:fieldAdded", window.Helpers.AutocompleteHelper.init_autocompleteProveedor
$(document).on "nested:fieldRemoved", window.Helpers.AutocompleteHelper.calcular_valores_factura
