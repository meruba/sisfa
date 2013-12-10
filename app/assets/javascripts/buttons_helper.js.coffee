window.Helpers ||= {}

window.Helpers.ButtonsHelper = {
  init: ->
    $(".crear_nuevo:not(.looks_like_button)").each ->
      $(this).addClass("looks_like_button btn btn-info").html "<i class='fa fa-plus'></i> " + $(this).html()

    $(".mostrar_show:not(.looks_like_button)").each ->
      $(this).addClass("looks_like_button btn").html "<i class='icon-eye-open'></i> " + $(this).html()

    $(".delete_destroy:not(.looks_like_button)").each ->
      $(this).addClass("looks_like_button btn btn-danger").html "<i class='icon-remove icon-white'></i> " + $(this).html()

    $(".editar_edit:not(.looks_like_button)").each ->
      $(this).addClass("looks_like_button btn").html "<i class='icon-edit'></i> " + $(this).html()

    $(".atras_back:not(.looks_like_button)").each ->
      $(this).addClass("looks_like_button btn btn-inverse").html "<i class='icon-arrow-left icon-white'></i> " + $(this).html()

    $(".cancel_button:not(.looks_like_button)").each ->
      $(this).addClass("looks_like_button btn btn-inverse").html "<i class='icon-remove icon-white'></i> " + $(this).html()

    $(".pencil_button:not(.looks_like_button)").each ->
      $(this).addClass("looks_like_button btn").html "<i class='icon-pencil'></i> " + $(this).html()

}

jQuery window.Helpers.ButtonsHelper.init
$(document).on "page:load", window.Helpers.ButtonsHelper.init
$(document).on "nested:fieldAdded", window.Helpers.ButtonsHelper.init
