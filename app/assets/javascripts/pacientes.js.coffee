# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  navListItems = $("ul.setup-panel li a")
  allWells = $(".setup-content")
  allWells.hide()
  navListItems.click (e) ->
    e.preventDefault()
    $target = $($(this).attr("href"))
    $item = $(this).closest("li")
    unless $item.hasClass("disabled")
      navListItems.closest("li").removeClass "active"
      $item.addClass "active"
      allWells.hide()
      $target.show()
    return

  $("ul.setup-panel li.active a").trigger "click"
  
  # DEMO ONLY //
  $("#activate-step-2").on "click", (e) ->
    $("ul.setup-panel li:eq(1)").removeClass "disabled"
    $(this).remove()
    return

  return
