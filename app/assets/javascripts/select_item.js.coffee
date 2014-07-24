window.Helpers.SelectItem = {
  selectChanged: ->
    $this = $(this)
    $wrapper = $this.closest(".new_item_entrega_turno")
    # console.log $wrapper
    switch $this.val()
      when "ayuna"
        $wrapper.find(".field_wrapper").find(".aislamiento-item").remove()
        $wrapper.find(".field_wrapper").find(".movimiento-item").remove()
        $wrapper.find(".field_wrapper").find(".descripcion-item").remove()
        $('<input class="form-control descripcion-item" id="item_entrega_turno_descripcion" name="item_entrega_turno[descripcion]" placeholder="Razones" type="text">').appendTo($wrapper.find(".field_wrapper"))
        $wrapper.find(".field_wrapper").find(".form-control").attr("placeholder", "Razones");

      when "examen"
        $wrapper.find(".field_wrapper").find(".aislamiento-item").remove()
        $wrapper.find(".field_wrapper").find(".movimiento-item").remove()
        $wrapper.find(".field_wrapper").find(".descripcion-item").remove()
        $('<input class="form-control descripcion-item" id="item_entrega_turno_descripcion" name="item_entrega_turno[descripcion]" placeholder="Razones" type="text">').appendTo($wrapper.find(".field_wrapper"))
        $wrapper.find(".field_wrapper").find(".form-control").attr("placeholder", "Examen");

      when "aislamiento"
        $wrapper.find(".field_wrapper").find(".descripcion-item").remove()
        $wrapper.find(".field_wrapper").find(".movimiento-item").remove()
        $('<select class="form-control aislamiento-item" id="item_entrega_turno_descripcion" name="item_entrega_turno[descripcion]"><option value="digestivo">digestivo</option><option value="respiratorio">respiratorio</option><option value="aseptico">aseptico</option><option value="septico">septico</option></select>').appendTo($wrapper.find(".field_wrapper"))

      when "defuncion"
        $wrapper.find(".field_wrapper").find(".aislamiento-item").remove()
        $wrapper.find(".field_wrapper").find(".movimiento-item").remove()
        $wrapper.find(".field_wrapper").find(".descripcion-item").remove()
        $('<input class="form-control descripcion-item" id="item_entrega_turno_descripcion" name="item_entrega_turno[descripcion]" placeholder="Razones" type="text">').appendTo($wrapper.find(".field_wrapper"))
        $wrapper.find(".field_wrapper").find(".form-control").attr("placeholder", "Hora de Defuncion ejm; 08:30");

      when "movimiento"
        $wrapper.find(".field_wrapper").find(".descripcion-item").remove()
        $wrapper.find(".field_wrapper").find(".aislamiento-item").remove()
        $('<select class="form-control movimiento-item" id="item_entrega_turno_descripcion" name="item_entrega_turno[descripcion]"><option value="ingreso">ingreso</option><option value="egreso">egreso</option><option value="transferencia">transferencia</option></select>').appendTo($wrapper.find(".field_wrapper"))

      when "grave"
        $wrapper.find(".field_wrapper").find(".aislamiento-item").remove()
        $wrapper.find(".field_wrapper").find(".movimiento-item").remove()
        $wrapper.find(".field_wrapper").find(".descripcion-item").remove()
        $('<input class="form-control descripcion-item" id="item_entrega_turno_descripcion" name="item_entrega_turno[descripcion]" placeholder="Razones" type="text">').appendTo($wrapper.find(".field_wrapper"))
        $wrapper.find(".field_wrapper").find(".form-control").attr("placeholder", "Causa");

  init: ->
    $(".item_entrega_turno").on "change", @selectChanged
    $(".item_entrega_turno").trigger "change"
}
