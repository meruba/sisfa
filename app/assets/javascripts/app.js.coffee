# PreventOpeningInNewWindow = {
#   init: ->
#     $(document).on "click", (e) ->
#       if e.ctrlKey or e.metaKey
#         e.preventDefault()
#         $(e.target).trigger("click")
#         false
#     $(document).on "contextmenu", (e) ->
#       e.preventDefault()
#       false
# }

# window.Helpers = {}

# PreventOpeningInNewWindow.init()

$(document).on 'ready page:load',
-> $("#tab_estadisticas").bind "contextmenu", (e) ->
  false

$(document).on "click", ".panel-heading span.clickable", (e) ->
  $this = $(this)
  unless $this.hasClass("panel-collapsed")
    $this.parents(".panel-compra").find(".form-producto").slideUp()
    $this.addClass "panel-collapsed"
    $this.removeClass("fa fa-chevron-up").addClass "fa fa-chevron-down"
  else
    $this.parents(".panel-compra").find(".form-producto").slideDown()
    $this.removeClass "panel-collapsed"
    $this.removeClass("fa fa-chevron-down").addClass "fa fa-chevron-up"
  return

$(document).on "click", ".btn-add", (event) ->
  event.preventDefault()
  field = $(this).closest(".field")
  field_new = field.clone()
  $(this).toggleClass("btn-default").toggleClass("btn-add").toggleClass("btn-danger").toggleClass("btn-remove").html "–"
  field_new.find("input").val ""
  field_new.insertAfter field

$(document).on "click", ".btn-remove", (event) ->
  event.preventDefault()
  $(this).closest(".field").remove()
