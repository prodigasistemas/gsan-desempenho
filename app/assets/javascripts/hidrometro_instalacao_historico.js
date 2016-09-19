$(function(){

  var nomeArquivo = "",
      intervalId = 0,
      registroHistorico = {},
      $btn = null;

  $("#btn-gerar-arquivo-hidrometro").click(function(event) {

    event.preventDefault();

    var data = {},
    data_inicial = $('#data_inicial').val(),
    data_final = $('#data_final').val();

    data['usuario_id'] = $('#usuario_id').val();

    if ( data_inicial && data_final ){
      data['data_inicial'] = data_inicial;
      data['data_final']   = data_final;
    }

    if ( (data_inicial !== "" && data_final === "") || (data_inicial === "" && data_final !== "") ){
      $(".alert-arquivo").html('<div class="alert alert-danger alert-dismissible" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>Informe um intervalo de datas!</div>')
      return;
    }

    data['localidade_id'] = $('#localidade_id').val();
    data['setor_comercial_id'] = $('#setor_comercial_id').val();
    data['rota_id'] = $('#rota_id :selected').val();
    data['quadra_id'] = $('#quadra_id').val();
    data['numero_lote'] = $('#numero_lote').val();
    data['numero_sublote'] = $('#numero_sublote').val();

    $btn = $(this).button('loading');

    $.ajax({
      url: BASE_URL + '/arquivo_hidrometro_instalacao_historicos',
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

      var empresa = response.empresa;
      var linhaTabela = "";

      nomeArquivo = response.nome_arquivo;
      registroHistorico = response.historico;
      registroHistorico.empresa = empresa;
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
      url: BASE_URL + '/verifica_arquivo_hidrometro_historico',
      type: 'get',
      dataType: 'json',
      data: { nome_arquivo: nomeArquivo },
    })
    .done(function(response) {

      if (response.success){
        clearInterval(intervalId);
        $btn.button('reset');

        $( "#" + registroHistorico.id ).find(".historico-situacao").html('<span class="label label-success">concluido</span>');
        $( "#" + registroHistorico.id ).find(".link-arquivo").html( '<a href="'+ BASE_URL +'/arquivo_hidrometro_instalacao_historicos.csv?nome_arquivo=' + nomeArquivo + '">'+ nomeArquivo +'</a>' );

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

    var responsavel = "";
    if(data.empresa != undefined) {
      responsavel = data.empresa.nome;
    } else {
      responsavel = data.usuario.nome
    }

    linhaTabela += "<td class='historico-responsavel'>" + responsavel + "</td>";
    linhaTabela += "<td class='link-arquivo'>" + data.caminho + "</td>";
    linhaTabela += "<td class='historico-situacao'><span class='label label-warning'>" + data.situacao_arquivo + "</span></td>";

    return linhaTabela;
  }

});