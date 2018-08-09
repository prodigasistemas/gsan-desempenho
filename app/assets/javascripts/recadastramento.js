$(function(){
  $('#query_periodo_inicial').mask('00/00/0000');
  $('#query_periodo_final').mask('00/00/0000');

  var cache = {},
  $localidade_id_inicial = $("#localidade_id_inicial"),
  $setor_comercial_inicial = $("#setor_comercial_inicial"),
  $setor_comercial_id_inicial = $("#setor_comercial_id_inicial"),
  $rota_inicial = $("#rota_id_inicial");

  if ( $localidade_id_inicial.val() !== "" ){
    $setor_comercial_inicial.attr('disabled', false);
  }

  if( $setor_comercial_id_inicial.length && $setor_comercial_id_inicial.val() !== "" ) {
    $rota_inicial.attr('disabled', false);

    carregarRotasInicial(function(){
      var rota_selecionada = $rota_inicial.data("rota-selecionada");
      if ( rota_selecionada ) $rota_inicial.val( rota_selecionada );
    });
  }

  $( "#localidade_inicial" ).autocomplete({
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
      $localidade_id_inicial.val(ui.item.id);
      $setor_comercial_inicial.attr("disabled", false);
    }
  });

  $setor_comercial_inicial.autocomplete({
    minLength: 2,
    source: function( request, response ) {
      var term = request.term;
      if ( term in cache ) {
        response( cache[ term ] );
        return;
      }
      request.filtros = { termo: term, localidade_id: $localidade_id_inicial.val() }
      $.getJSON( BASE_URL + "/setor_comercial", request, function( data, status, xhr ) {
        var result = $.map(data.entidades, function (value, key) {
          return {
            id: value.id,
            label: value.nome,
            value: value.nome,
            codigo: value.codigo
          };
        });
        cache[ term ] = result;
        response( result );
      });
    },
    select: function(event, ui){
      $setor_comercial_id_inicial.val(ui.item.codigo);
      $rota_inicial.attr("disabled", false);
      carregarRotasInicial();
    }
  });

  function carregarRotasInicial(callback){
    $rota_inicial.empty();
    var request = {};
    $rota_inicial.append('<option value=""></option>')
    request.filtros = { setor_comercial_id: $setor_comercial_id_inicial.val() };
    $.getJSON( BASE_URL + "/rotas", request, function( data, status, xhr ) {
      $.each(data.entidades, function(index, value) {
          $rota_inicial.append('<option value="'+ value.codigo +'">'+ value.codigo +'</option>')
      });
      if (callback) callback();
    });
  }

  var cache = {},
  $localidade_id_final = $("#localidade_id_final"),
  $setor_comercial = $("#setor_comercial_final"),
  $setor_comercial_id_final = $("#setor_comercial_id_final"),
  $rota_final = $("#rota_id_final");

  if ( $localidade_id_final.val() !== "" ){
    $setor_comercial.attr('disabled', false);
  }

  if( $setor_comercial_id_final.length && $setor_comercial_id_final.val() !== "" ){
    $rota_final.attr('disabled', false);

    carregarRotas(function(){
      var rota_selecionada = $rota_final.data("rota-selecionada");
      if ( rota_selecionada ) $rota_final.val( rota_selecionada );
    });
  }

  $( "#localidade_final" ).autocomplete({
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
      $localidade_id_final.val(ui.item.id);
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

      request.filtros = { termo: term, localidade_id: $localidade_id_final.val() }

      $.getJSON( BASE_URL + "/setor_comercial", request, function( data, status, xhr ) {
        var result = $.map(data.entidades, function (value, key) {
          return {
            id: value.id,
            label: value.nome,
            value: value.nome,
            codigo: value.codigo
          };
        });

        cache[ term ] = result;
        response( result );
      });
    },
    select: function(event, ui){
      $setor_comercial_id_final.val(ui.item.codigo);
      $rota_final.attr("disabled", false);

      carregarRotas();
    }
  });

  function carregarRotas(callback){
    $rota_final.empty();
    var request = {};
    $rota_final.append('<option value=""></option>')
    request.filtros = { setor_comercial_id: $setor_comercial_id_final.val() };

    $.getJSON( BASE_URL + "/rotas", request, function( data, status, xhr ) {
      $.each(data.entidades, function(index, value) {
          $rota_final.append('<option value="'+ value.codigo +'">'+ value.codigo +'</option>')
      });

      if (callback) callback();
    });
  }


  // Recarregar combo de leituristas de acordo com a empresa
  $('#query_empresa_id').change(function() {
    var empresa_id = $(this).val(),
    $leituristasSelect = $('#query_leiturista_id');
    $leituristasSelect.empty();
    $leituristasSelect.append($("<option></option>").attr("value", "").text("Escolha"));
    var request = {};
    request.query = { empr_id: empresa_id };
    $.getJSON( BASE_URL + "/leituristas", request, function( data, status, xhr ) {
      $.each(data.entidades, function(index, value) {
        $leituristasSelect.append($("<option></option>").attr("value", value.id).text(value.nome));
      });
    })
  });

  $("input:radio[name='query[exibir_imoveis]']").change(function() {
    if ($(this).is(':checked') && $(this).val() == '-2') {
      $("#query_alteracao_hidrometro_no").prop('checked', true);
      $("#query_alteracao_agua_no").prop('checked', true);
      $("#query_alteracao_esgoto_no").prop('checked', true);
      $("#query_alteracao_categoria_subcategoria_no").prop('checked', true);
      disabilitarRadios();
    } else if ($(this).is(':checked') && $(this).val() == '-1') {
      $("#query_alteracao_hidrometro_all").prop('checked', true);
      $("#query_alteracao_agua_all").prop('checked', true);
      $("#query_alteracao_esgoto_all").prop('checked', true);
      $("#query_alteracao_categoria_subcategoria_all").prop('checked', true);
      disabilitarRadios();
    } else {
      $("input:radio[name='query[alteracao_hidrometro]']").removeAttr('disabled');
      $("input:radio[name='query[alteracao_agua]']").removeAttr('disabled');
      $("input:radio[name='query[alteracao_esgoto]']").removeAttr('disabled');
      $("input:radio[name='query[alteracao_categoria_subcategoria]']").removeAttr('disabled');
    }
  });

  function disabilitarRadios() {
    $("input:radio[name='query[alteracao_hidrometro]']").prop('disabled', true);
    $("input:radio[name='query[alteracao_agua]']").prop('disabled', true);
    $("input:radio[name='query[alteracao_esgoto]']").prop('disabled', true);
    $("input:radio[name='query[alteracao_categoria_subcategoria]']").prop('disabled', true);
  }

  $("input:radio[name='query[ocorrencias_cadastro]']").change(function() {
    if ($(this).is(':checked') && $(this).val() == '2') {
      $("#query_cadastro_ocorrencia_id").removeAttr('disabled');
    } else {
      $('#query_cadastro_ocorrencia_id').val('');
      $("#query_cadastro_ocorrencia_id").prop('disabled', true);
    }
  });
});
