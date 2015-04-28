window.Helpers ||= {}

window.Helpers.ShowForm = {
  init: ->
    $('.show-form').on 'click', ->
      $this = $(this)
      $this.parent().next().toggle('show')
  init_form_2: ->
    $('.show-form-2').on 'click', ->
      $this = $(this)
      $this.parent().siblings('.form-tratamiento').toggle('show')
      $this.parent().siblings('.hoja-tratamientos').toggle('hide')
      if $this.hasClass("fa fa-plus")
        $this.removeClass("fa fa-plus").addClass "fa fa-chevron-up"
      else
        $this.removeClass("fa fa-chevron-up").addClass "fa fa-plus"


}

jQuery window.Helpers.ShowForm.init
jQuery window.Helpers.ShowForm.init_form_2
$(document).on "page:load", window.Helpers.ShowForm.init
$(document).on "page:load", window.Helpers.ShowForm.init_form_2
