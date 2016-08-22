$(function(){
  
  $("#btn-gerar-arquivo").click(function(event) {

    event.preventDefault();
    
    $.ajax({
      url: BASE_URL + '/arquivo_recadastramento',
      type: 'post',
      dataType: 'json',
      data: { usuario_id: $("#usuario_id").val() },
    })
    .done(function() {
      console.log("success");
    })
    .fail(function() {
      console.log("error");
    })
    .always(function() {
      console.log("complete");
    });
    

  });

})