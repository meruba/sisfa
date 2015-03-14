$(document).on "ready page:load", ->
  $(".type-search-factura").on "change", ->
    $this = $(this)
    $this.parent().siblings(".tipo1").toggle("show")
    $this.parent().siblings(".tipo2").toggle("show")
