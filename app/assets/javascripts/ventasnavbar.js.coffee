window.Helpers.NavbarVentas = {
  $selector: null
  $nav: null
  
  clicked_estadisticas: (e) ->
    self = window.Helpers.NavbarVentas
    $this = $(this)
    self.$nav.find("li").removeClass("active")
    self.$content.html("cargando..")
    $this.parent().addClass("active")

  init_estadisticas: ->
    this.$content = $(".tab-content")
    this.$nav = $("#tab_estadisticas")
    this.$selector = this.$nav.find("li a")
    this.$selector.on "click", this.clicked_estadisticas
}