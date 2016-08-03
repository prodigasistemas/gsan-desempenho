$(function(){
  var cache = {},
  $matricula = $("#matricula"),
  $localidade_id = $("#localidade_id"),
  $setor_comercial = $("#setor_comercial"),
  $setor_comercial_id = $("#setor_comercial_id"),
  $rota = $("#rota_id")
  $quadra = $("#quadra_id"),
  $quadra_id = $("#quadra_id");

  if ( $localidade_id.val() !== "" ){
    $setor_comercial.attr('disabled', false);
  }

  if( $setor_comercial_id.length && $setor_comercial_id.val() !== "" ){
    $rota.attr('disabled', false);
    $quadra.attr('disabled', false);

    carregarRotas(function(){
      var rota_selecionada = $rota.data("rota-selecionada");
      
      if ( rota_selecionada ) $rota.val( rota_selecionada );
    });

    carregarQuadras(function(){
      var quadra_selecionada = $quadra.data("quadra-selecionada");
      
      if ( quadra_selecionada ) $quadra.val( quadra_selecionada );
    });
  }

  if( $rota.val() !== "" ){
    $quadra_id.attr('disabled', false);
  }

  $matricula.keyup(function(event) {
    var matricula = $(this).val();

    if(matricula){
      $( "#localidade" ).attr("disabled", true);
    }
    else{
      $( "#localidade" ).attr("disabled", false);
    }

  });

  $( "#mostrar-pesquisa-avancada" ).click(function(event) {
    event.preventDefault();

    var $pesquisaAvancada = $( "#pesquisa-avancada" );

    if( $pesquisaAvancada.hasClass('hide') ){
      $pesquisaAvancada.removeClass("hide");  
    }
    else{
      $pesquisaAvancada.addClass("hide");  
    }
    
  });

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
      $localidade_id.val(ui.item.id);
      $setor_comercial.attr("disabled", false);
    }
  });

  $setor_comercial.autocomplete({
    minLength: 2,
    source: function( request, response ) {
      var term = request.term;
      if ( term in cache ) {
        response( cache[ term ] );
        return;
      }

      request.filtros = { termo: term, localidade_id: $localidade_id.val() }

      $.getJSON( BASE_URL + "/setor_comercial", request, function( data, status, xhr ) {
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
      $setor_comercial_id.val(ui.item.id);
      $rota.attr("disabled", false);
      $quadra.attr("disabled", false);

      carregarRotas();
      carregarQuadras();
    }
  });

  // $quadra.autocomplete({
  //   minLength: 2,
  //   source: function( request, response ) {
  //     var term = request.term;
  //     if ( term in cache ) {
  //       response( cache[ term ] );
  //       return;
  //     }

  //     request.filtros = { termo: term, setor_comercial_id: $setor_comercial_id.val() }

  //     $.getJSON( BASE_URL + "/quadras", request, function( data, status, xhr ) {
  //       var result = $.map(data.entidades, function (value, key) {
  //         return {
  //           id: value.id,
  //           label: value.codigo,
  //           value: value.codigo
  //         };
  //       });

  //       cache[ term ] = result;
  //       response( result );
  //     });
  //   },
  //   select: function(event, ui){
  //     $quadra_id.val(ui.item.id);
  //   }
  // });

  function carregarRotas(callback = null){
    $rota.empty();

    var request = {};

    $rota.append('<option value=""></option>')

    request.filtros = { setor_comercial_id: $setor_comercial_id.val() };

    $.getJSON( BASE_URL + "/rotas", request, function( data, status, xhr ) {
      
      $.each(data.entidades, function(index, value) {
         
          $rota.append('<option value="'+ value.id +'">'+ value.codigo +'</option>')

      });

      if (callback) callback();

    });
  }

  function carregarQuadras(callback = null){
    $quadra.empty();

    var request = {};

    $quadra.append('<option value=""></option>')

    request.filtros = { setor_comercial_id: $setor_comercial_id.val() };

    $.getJSON( BASE_URL + "/quadras", request, function( data, status, xhr ) {
      
      $.each(data.entidades, function(index, value) {
         
          $quadra.append('<option value="'+ value.id +'">'+ value.numero_quadra +'</option>')

      });

      if (callback) callback();

    });
  }
});
