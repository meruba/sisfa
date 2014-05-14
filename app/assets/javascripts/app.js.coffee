$(document).on 'ready page:load',
-> $("#tab_estadisticas").bind "contextmenu", (e) ->
  false
  
# $(document).on 'ready page:load',
# -> $('body').css('background-color','#F3F3F3')

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

$(document).on 'ready page:load',
-> $(".tipo").each ->
    tipo =  $(this).text()
    switch tipo
      when "MILITAR" then $(this).css("color","#94D5AD")
      when "CIVIL" then $(this).css("color","#2dc1e6")
      when "FAMILIAR" then $(this).css("color","#E77666")

$ ->
  $("#input-search").on "keyup", ->
    rex = new RegExp($(this).val(), "i")
    $(".searchable-container .items").hide()
    $(".searchable-container .items").filter(->
      rex.test $(this).text()
    ).show()

$(document).on "ready page:load", ->
  $("#rootwizard").bootstrapWizard()
