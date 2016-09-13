$(function(){

  var nomeArquivo = "",
      intervalId = 0,
      $btn = null;
  
  $("#btn-gerar-arquivo").click(function(event) {

    event.preventDefault();
    var data = {},
    data_inicial = $("#data-inicial").val(),
    data_final = $("#data-final").val()
    empresaId = $("#lista-empresas").val();

    data['empresa_id'] = empresaId;

    if ( data_inicial && data_final ){
      console.log(data_inicial)
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
    console.log(data)
    
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

      nomeArquivo = response.nome_arquivo;

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
        window.location = BASE_URL + "/arquivo_recadastramento.csv?nome_arquivo=" + nomeArquivo;
        clearInterval(intervalId);
        $btn.button('reset');
      }

    })
    .fail(function() {
      console.log("error");
    })
    .always(function() {
      console.log("complete");
    });
  }

});