$(function() {
  $('#cedula').autocomplete({
    minLength: 3,
    source: '/clientes.json',
    select: nombre
  });
      function nombre(event, ui)
    {
      $( "#cedula" ).val( ui.item.numero_de_identificacion + " / " + ui.item.nombre );
      return false;
    }
          function set_values(event, ui)
    {
      var direccion = ui.item.direccion;
      
      // actualizamos los datos en el formulario
      $("#direccion").text(direccion);
    }
//     $("#search").autocomplete({
//         source: function(request, response) {
//             $.get("http://ws.spotify.com/search/1/track.json", {
//                 q: request.term
//             }, function(data) {
//                 response($.map(data.tracks, function (el) {
//                     return el.name;
//                 }));
//             });
//         }
//     }).on('focus', function(event) {
//     var self = this;
//     $(self).autocomplete( "search", this.value);;
// });

});
