$(function(){

  var nomeArquivo = "",
      intervalId = 0,
      registroHistorico = {},
      $btn = null;

  $('#referencia').mask('00/0000');

  $("#btn-gerar-relatorio-medicao-performance").click(function(event) {

    event.preventDefault();

    var referencia = $('#referencia').val().split("/");
    var regex = /^(0?[1-9]|1[012])[\/\-]\d{4}$/;
    if(!regex.test($('#referencia').val())){
      alert("Referência inválida");
      return;
    }

    data                        = {};
    data['usuario_id']          = $('#usuario_id').val();
    data['contrato_medicao_id'] = $('#contrato_medicao').val();
    data['localidade_id']       = $('#localidade_id').val();
    data['setor_comercial_id']  = $('#setor_comercial_id').val();
    data['rota_id']             = $('#rota_id :selected').val();
    data['referencia']          = referencia[1] + referencia[0];
    data['tipo']                = $('input[name=tipo]:checked').val();
    data['formato']             = "xls";
    if(data.tipo == "sintetico") {
      data['formato'] = "pdf";
    }

    $btn = $(this).button('loading');

    $.ajax({
      url: BASE_URL + '/arquivo_medicao_performance_relatorios',
      type: 'post',
      dataType: 'json',
      data: data
    })
    .done(function(response) {
      if (!response.success){
        $(".alert-arquivo").html('<div class="alert alert-danger" role="alert">'+ response.message +'</div>')
        $btn.button('reset');
        return;
      }

      var linhaTabela = "";

      nomeArquivo = response.nome_arquivo;
      registroHistorico = response.historico;
      registroHistorico.responsavel = response.responsavel;
      registroHistorico.nome_arquivo = nomeArquivo;
      linhaTabela = linhaDaTabela(registroHistorico);

      $("#historico-geracao").prepend(linhaTabela)

      intervalId = setInterval(function(){
        poolingVerificaSeArquivoExiste(nomeArquivo);
      }, 10000);

    })
    .fail(function() {
      console.log("error");
    })
    .always(function() {
      console.log("complete");
    });


  });

  function poolingVerificaSeArquivoExiste(nomeArquivo, formato_arquivo){
    $.ajax({
      url: BASE_URL + '/verifica_arquivo_medicao_performance_relatorios',
      type: 'get',
      dataType: 'json',
      data: { nome_arquivo: nomeArquivo },
    })
    .done(function(response) {
      if (response.success){
        clearInterval(intervalId);
        $btn.button('reset');

        $( "#" + registroHistorico.id ).find(".historico-situacao").html('<span class="label label-success">concluido</span>');
        $( "#" + registroHistorico.id ).find(".link-arquivo").html( '<a href="'+ BASE_URL +'/arquivo_medicao_performance_relatorios. ' + data['formato'] + '?nome_arquivo=' + nomeArquivo + '">'+ nomeArquivo +'</a>' );
      }

    })
    .fail(function() {
      $( "#" + registroHistorico.id ).find(".historico-situacao").html('<span class="label label-danger">falha</span>');
    })
    .always(function() {
      console.log("complete");
    });
  }

  function linhaDaTabela(data){
    console.log(data);
    var linhaTabela = "<tr id='"+ data.id +"'>";
    linhaTabela += "<td class='historico-id'>" + data.id + "</td>";
    linhaTabela += "<td class='historico-responsavel'>" + data.responsavel + "</td>";
    linhaTabela += "<td class='link-arquivo'>" + data.nome_arquivo + "</td>";
    linhaTabela += "<td class='historico-situacao'><span class='label label-warning'>" + data.situacao_arquivo + "</span></td>";

    return linhaTabela;
  }

});