$(function(){

  $("#btn-gerar-relatorio").click(function(event) {

    event.preventDefault();

    var data = {}

    data['contrato_medicao_id'] = $('#contrato_medicao').val();
    data['localidade_id']       = $('#localidade_id').val();
    data['setor_comercial_id']  = $('#setor_comercial_id').val();
    data['rota_id']             = $('#rota_id :selected').val();
    data['referencia']          = $('#referencia').val();
    data['formato']             = $('input[name=formato]:checked').val();

    $btn = $(this).button('loading');

    $.ajax({
      url: BASE_URL + '/medicao_performances/relatorio',
      type: 'get',
      dataType: 'json',
      data: data
    })
    .done(function(response) {
      if (!response.success){
        $(".alert-arquivo").html('<div class="alert alert-danger" role="alert">'+ response.error +'</div>')
        $btn.button('reset');
        return;
      }

      window.location = response.url;

      $btn.button('reset');
    })
    .fail(function() {
      console.log("error");
    })
  });
});