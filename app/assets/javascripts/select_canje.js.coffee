window.Helpers.SelectCanje = {
  selectChanged: ->
    $this = $(this)
    $wrapper = $this.closest(".canje_form")
    if $this.val() is "mismo_producto"
      $wrapper.find(".mismo_producto_wrapper").slideDown()
      $wrapper.find(".nuevo_producto_wrapper").slideUp()
    else
      $wrapper.find(".mismo_producto_wrapper").slideUp()
      $wrapper.find(".nuevo_producto_wrapper").slideDown()
    
  init: ->
    $(".select_tipo_canje").on "change", @selectChanged
    $(".select_tipo_canje").trigger "change"
}
