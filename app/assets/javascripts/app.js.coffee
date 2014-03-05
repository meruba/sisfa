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