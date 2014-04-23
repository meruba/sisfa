window.Helpers.SelectPaciente = {
  selectChanged: ->
    $this = $(this)
    $wrapper = $this.closest(".historia_form")
    switch $this.val()
      when "militar"
        $wrapper.find(".familiar_wrapper").fadeOut()
        $wrapper.find(".civil_wrapper").fadeOut()
        $wrapper.find(".militar_wrapper").fadeIn()
      when "familiar"
        $wrapper.find(".militar_wrapper").fadeOut()
        $wrapper.find(".civil_wrapper").fadeOut()
        $wrapper.find(".familiar_wrapper").fadeIn()
      when "civil"
        $wrapper.find(".militar_wrapper").fadeOut()
        $wrapper.find(".familiar_wrapper").fadeOut()
        $wrapper.find(".civil_wrapper").fadeIn()
  init: ->
    $(".select_paciente").on "change", @selectChanged
    $(".select_paciente").trigger "change"
}