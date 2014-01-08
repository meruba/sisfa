window.Helpers.NavbarVentas = {
  $selector: null
  $nav: null
  clicked: (e) ->
    self = window.Helpers.NavbarVentas
    $this = $(this)
    self.$nav.find("li").removeClass("active")
    self.$content.html("cargando..")
    $this.parent().addClass("active")
  init: ->
    this.$content = $(".tab-content")
    this.$nav = $("#tab_ventas")
    this.$selector = this.$nav.find("li a")
    this.$selector.on "click", this.clicked
}