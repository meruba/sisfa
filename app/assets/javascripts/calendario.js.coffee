window.Helpers ||= {}

window.Helpers.CalendarHelper = {
  init: ->
    $('div .days-turno').each ->
      $this = $(this)
      if $this.hasClass("lleno")
        $this.parent().addClass("is-full")
      else
        $this.parent().addClass("is-aviable")
}

jQuery window.Helpers.CalendarHelper.init
$(document).on "page:load", window.Helpers.CalendarHelper.init
