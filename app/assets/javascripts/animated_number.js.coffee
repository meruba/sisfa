window.Helpers ||= {}

window.Helpers.AnimateNumber = {
  init: ->
    $(".anim").each ->
      window.Helpers.AnimateNumber.animate($(this))

  animate: (el) ->
    currentCount = parseInt(el.html())
    target = parseInt(el.attr("data-target"))
    if currentCount is target
      return
    else
      currentCount++
      el.html currentCount + ""
    setTimeout (->
      window.Helpers.AnimateNumber.animate el
    ), 100
}


jQuery window.Helpers.AnimateNumber.init
$(document).on "ready page:load", window.Helpers.AnimateNumber.init
