window.Helpers ||= {}

window.Helpers.FormsHelper = {
  setFormClasses: ->
    for form in $("form")
      $form = $(form)
      $form.find(".field").addClass("form-group").find('input').addClass("form-control")
    null
  init: ->
    @setFormClasses()
    null
}

jQuery ->
  window.Helpers.FormsHelper.init()
$(document).on "page:load", ->
  window.Helpers.FormsHelper.init()