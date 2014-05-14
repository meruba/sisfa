window.Helpers.SearchHelper = {
  init: ->
  	$("#input-search").on "keyup", ->
  		rex = new RegExp($(this).val(), "i")
  		$(".searchable-container .items").hide()
  		$(".searchable-container .items").filter(->
  			rex.test $(this).text()
  			).show()
}

jQuery window.Helpers.SearchHelper.init
$(document).on "page:load", window.Helpers.SearchHelper.init
