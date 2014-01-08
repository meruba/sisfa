window.Helpers ||= {}

window.Helpers.AutocompleteHelper = {
  init_autocomplete: ->
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
      response: (event, ui) ->
        unless ui.content.length
          noResult =
            value: ""
            label: "Ningun Resultado"
          ui.content.push noResult
        else
          $("#message").empty()
      select: (event, ui) ->
        $this = $(this)
        $this.closest(".fields").find("td:nth-child(2)").find(".producto_id").val ui.item.id
        # $this.closest(".fields").find("td:nth-child(1)").find(".codigo").val ui.item.codigo
        $this.closest(".fields").find("td:nth-child(3)").find(".valor_unitario").val ui.item.precio_a
        window.Helpers.AutocompleteHelper.calcular_total_producto($this)
        window.Helpers.AutocompleteHelper.calcular_valores_factura()

    $(".cantidad").on "input", ->
      $this = $(this)
      calcular_total_producto($this)
      calcular_valores_factura()

    $(".eliminar_item").on "click", ->
      $this = $(this)
      $this.closest(".fields").remove()
      calcular_valores_factura()

  calcular_total_producto: (componente) ->
    cantidad = componente.closest(".fields").find("td:nth-child(2)").find(".cantidad").val()
    valor_unitario = componente.closest(".fields").find("td:nth-child(3)").find(".valor_unitario").val()
    total = componente.closest(".fields").find("td:nth-child(6)").find(".total")
    total.val(cantidad * valor_unitario)

  calcular_valores_factura: ->
    sum = 0
    $(".total").each ->
      sum += parseFloat($(this).val())
    $(".subtotal_0").val sum
    $(".subtotal_12").val sum
    $(".descuento_factura").val 0
    $(".iva_factura").val((sum*0.12).toFixed(2));
    $(".total_factura").val((sum*0.12+sum).toFixed(2));
}

jQuery window.Helpers.AutocompleteHelper.init
$(document).on "page:load", window.Helpers.AutocompleteHelper.init_autocomplete
# jQuery ->
#   init_autocomplete()
# $(document).on "page:load", init_autocomplete
$(document).on "nested:fieldAdded", window.Helpers.AutocompleteHelper.init_autocomplete
# $(document).on "nested:fieldRemoved", init_autocomplete
