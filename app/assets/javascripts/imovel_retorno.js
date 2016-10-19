$(function(){

  var nomeArquivo = "",
      intervalId = 0,
      registroHistorico = {},
      $btn = null;

  $("#btn-gerar-arquivo").click(function(event) {

    event.preventDefault();
    var data = {},
    data_inicial = $("#data-inicial").val(),
    data_final = $("#data-final").val()
    empresaId = $("#lista-empresas").val()
    usuarioId = $("#usuario-id").val();

    data['empresa_id'] = empresaId;
    data['usuario_id'] = usuarioId;

    if ( data_inicial && data_final ){
      data['data_inicial'] = data_inicial;
      data['data_final']   = data_final;
    }

    if ( empresaId === "" || empresaId === undefined ){
      $(".alert-arquivo").html('<div class="alert alert-danger alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>Selecione uma empresa!</div>')
      return;
    }

    if ( (data_inicial !== "" && data_final === "") || (data_inicial === "" && data_final !== "") ){
      $(".alert-arquivo").html('<div class="alert alert-danger alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>Informe um intervalo de datas!</div>')
      return;
    }

    $btn = $(this).button('loading');

    $.ajax({
      url: BASE_URL + '/arquivo_recadastramento',
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

  function poolingVerificaSeArquivoExiste(nomeArquivo){
    $.ajax({
      url: BASE_URL + '/verifica_arquivo_recadastramento',
      type: 'get',
      dataType: 'json',
      data: { nome_arquivo: nomeArquivo },
    })
    .done(function(response) {

      if (response.success){
        clearInterval(intervalId);
        $btn.button('reset');

        $( "#" + registroHistorico.id ).find(".historico-situacao").html('<span class="label label-success">concluido</span>');
        $( "#" + registroHistorico.id ).find(".link-arquivo").html( '<a href="'+ BASE_URL +'/arquivo_recadastramento.csv?nome_arquivo=' + nomeArquivo + '">'+ nomeArquivo +'</a>' );

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
    var linhaTabela = "<tr id='"+ data.id +"'>";
    linhaTabela += "<td class='historico-id'>" + data.id + "</td>";
    linhaTabela += "<td class='historico-responsavel'>" + data.responsavel + "</td>";
    linhaTabela += "<td class='link-arquivo'>" + data.nome_arquivo + "</td>";
    linhaTabela += "<td class='historico-situacao'><span class='label label-warning'>" + data.situacao_arquivo + "</span></td>";

    return linhaTabela;
  }

});