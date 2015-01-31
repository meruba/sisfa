window.Helpers ||= {}

window.Helpers.CalendarHelper = {
  init: ->
  	$(".disponible").each ->
  		$this = $(this)
  		$this.parent().addClass("is-aviable")

    $(".lleno").each ->
  		$this = $(this)
  		$this.parent().addClass("is-full")
}

jQuery window.Helpers.CalendarHelper.init
$(document).on "page:load", window.Helpers.CalendarHelper.init
