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

$(document).ready ->
  $("#tab_ventas").bind "contextmenu", (e) ->
  	false