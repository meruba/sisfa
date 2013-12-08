$ ->
  flashCallback = ->
    $(".alert").slideUp ->
    	$(this).remove()
  setTimeout flashCallback, 3000