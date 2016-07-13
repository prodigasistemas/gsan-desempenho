$(function(){
  $('.date-br').mask('00/00/0000');
  
  $('.item-list').click(function(e){
      var idItem = $(this).data("item-id");
      var showItem = $(this).data("show-item");

      window.location = "/"+showItem+"/"+idItem;
  });

  $(document).bind("ajaxComplete", function(e){
  
    if ( $(e.currentTarget.forms[0]).hasClass('smart-listing-controls') ){
      $('.item-list').click(function(e){
        var idItem = $(this).data("item-id");
        var showItem = $(this).data("show-item");

        window.location = "/"+showItem+"/"+idItem;
      });
    }
  });
});