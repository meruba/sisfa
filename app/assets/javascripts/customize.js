$(document).ready(function() {
  // change genero icon
  genero = $(".genero").text()
  if (genero = "GENERO:FEMENINO") {
    $(".genero-icon").removeClass("fa-male").addClass("fa-female");
  };
  // result = $('#atendido li').length >= 1
  // console.log(result);
  // if (result == false ) {
  //   $("#atendido").html("<span class='text-muted'>No hay Turnos<span>")
  // };
});



