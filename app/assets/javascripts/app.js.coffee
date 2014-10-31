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

$ ->
  $("#input-search").on "keyup", ->
    rex = new RegExp($(this).val(), "i")
    $(".searchable-container .items").hide()
    $(".searchable-container .items").filter(->
      rex.test $(this).text()
    ).show()

$(document).on "ready page:load", ->
  #form_wizard
  $("#rootwizard").bootstrapWizard()
  #list-whit-option
  $(".list-group-item > .show-menu").on "click", (event) ->
    event.preventDefault()
    $(this).closest("li").toggleClass "open"
  #timepicker
  $('#input_from').pickatime(
    min: [8,30]
    max: [14,30]
    )
  $('#input_to').pickatime(
    min: [9,0]
    max: [14,30]
    )
  #select check
  $("#radioBtn a").on "click", ->
    sel = $(this).data("title")
    tog = $(this).data("toggle")
    $("#" + tog).prop "value", sel
    $("a[data-toggle=\"" + tog + "\"]").not("[data-title=\"" + sel + "\"]").removeClass("active").addClass "notActive"
    $("a[data-toggle=\"" + tog + "\"][data-title=\"" + sel + "\"]").removeClass("notActive").addClass "active"

  $(".card").click ->
    $(this).toggleClass "flipped"
  
  $("#otros_dias").on "click", ->
    $this = $(this)
    if $this.is(':checked') == true
      $.get("/emisors/1/turnos_otros_dias");
      alertify.success("Turnos habilitados para otras fechas")
    else
      $.get("/emisors/1/turnos_otros_dias");
      alertify.log("Turnos desahabilitados para otras fechas")

