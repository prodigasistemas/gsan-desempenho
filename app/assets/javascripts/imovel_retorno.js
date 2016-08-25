$(function(){

  var nomeArquivo = "",
      intervalId = 0,
      $btn = null;
  
  $("#btn-gerar-arquivo").click(function(event) {

    event.preventDefault();

    $btn = $(this).button('loading');
    
    $.ajax({
      url: BASE_URL + '/arquivo_recadastramento',
      type: 'post',
      dataType: 'json',
      data: { usuario_id: $("#usuario_id").val() },
    })
    .done(function(response) {
      if (!response.success){
        $(".container-arquivo").html('<div class="alert alert-danger" role="alert">'+ response.message +'</div>')
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