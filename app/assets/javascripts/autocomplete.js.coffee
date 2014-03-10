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
        $this.closest(".fields").find("td:nth-child(3)").find(".valor_unitario").val ui.item.precio_venta
        $this.closest(".fields").find("td:nth-child(8)").find(".hasiva").val ui.item.iva
        if ui.item.iva == true
          precio_venta = ui.item.precio_venta
          iva_producto = precio_venta * 0.12
          # precio_sin_iva = precio_venta - iva_producto
          $this.closest(".fields").find("td:nth-child(5)").find(".iva").val iva_producto.toFixed(2)
          # $this.closest(".fields").find("td:nth-child(3)").find(".valor_unitario").val ui.item.precio_venta
        window.Helpers.AutocompleteHelper.calcular_total_producto($this)
        window.Helpers.AutocompleteHelper.sumar_iva()
        window.Helpers.AutocompleteHelper.calcular_valores_factura()

    $(".cantidad").on "input", ->
      $this = $(this)
      window.Helpers.AutocompleteHelper.calcular_total_producto($this)
      window.Helpers.AutocompleteHelper.sumar_iva()
      window.Helpers.AutocompleteHelper.calcular_valores_factura()

    $(".eliminar_item").on "click", ->
      $this = $(this)
      $this.closest(".fields").remove()
      window.Helpers.AutocompleteHelper.sumar_iva()      
      window.Helpers.AutocompleteHelper.calcular_valores_factura()

  sumar_iva: -> 
    sum = 0
    $(".iva").each ->
      sum += parseFloat($(this).val())
    $(".iva_factura").val(sum.toFixed(2));

  calcular_total_producto: (componente) ->
    cantidad = componente.closest(".fields").find("td:nth-child(2)").find(".cantidad").val()
    valor_unitario = componente.closest(".fields").find("td:nth-child(3)").find(".valor_unitario").val()
    hasiva = componente.closest(".fields").find("td:nth-child(8)").find(".hasiva").val()
    if hasiva == "true"
      iva_producto = valor_unitario * 0.12
      componente.closest(".fields").find("td:nth-child(5)").find(".iva").val((cantidad * iva_producto).toFixed(2))
    total = componente.closest(".fields").find("td:nth-child(6)").find(".total")
    total.val((cantidad * valor_unitario).toFixed(2))

  calcular_valores_factura: ->
    sum = 0
    $(".total").each ->
      sum += parseFloat($(this).val())
    $(".subtotal_0").val sum.toFixed(2)
    $(".subtotal_12").val sum.toFixed(2)
    $(".descuento_factura").val 0
    # $(".iva_factura").val((sum*0.12).toFixed(2));
    $(".total_factura").val((sum*0.12+sum).toFixed(2));

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
