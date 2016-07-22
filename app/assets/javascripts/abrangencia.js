$(function(){
  var cache = {};

  $( "#localidade" ).autocomplete({
      minLength: 2,
      source: function( request, response ) {
        var term = request.term;
        if ( term in cache ) {
          response( cache[ term ] );
          return;
        }

        request.tipo = "localidade";
        request.filtros = { termo: term }

        $.getJSON( BASE_URL + "/filtros", request, function( data, status, xhr ) {
          var result = $.map(data.entidades, function (value, key) {
            return {
              id: value.id,
              label: value.nome,
              value: value.nome
            };
          });

          cache[ term ] = result;
          response( result );
        });
      },
      select: function(event, ui){
        $("#localidade_id").val(ui.item.id)
      }
    });

    $( "#setor_comercial" ).autocomplete({
      minLength: 2,
      source: function( request, response ) {
        var term = request.term;
        if ( term in cache ) {
          response( cache[ term ] );
          return;
        }

        request.tipo = "setor_comercial";
        request.filtros = { termo: term }

        $.getJSON( BASE_URL + "/filtros", request, function( data, status, xhr ) {
          var result = $.map(data.entidades, function (value, key) {
            return {
              id: value.id,
              label: value.nome,
              value: value.nome
            };
          });

          cache[ term ] = result;
          response( result );
        });
      },
      select: function(event, ui){
        $("#setor_comercial_id").val(ui.item.id)
      }
    });
  });