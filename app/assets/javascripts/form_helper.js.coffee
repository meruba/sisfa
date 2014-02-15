window.Helpers ||= {}

window.Helpers.FormsHelper = {
  setFormClasses: ->
    for form in $("form")
      $form = $(form)
      $form.find(".field").addClass("form-group").find('input').addClass("form-control").css("border-radius": "0px")
    null

  AddIconInput: ->
    for form in $("form")
      $form = $(form)
      $form.find(".input-icon-sm").css("padding-bottom":"10px").addClass("icon-addon addon-sm").find('input').addClass("form-control")
    null

  init: ->
    @setFormClasses()
    @AddIconInput()
    null
}

jQuery ->
  window.Helpers.FormsHelper.init()
$(document).on "page:load", ->
  window.Helpers.FormsHelper.init()