$(function(){
  var height = $("body").height();

  $(".sidebar").height(height);

  $(".btn-menu").click(function(e){
    e.preventDefault();

    $(".sidebar").toggle("slide")
  });

  $(".main").click(function(){
    $(".sidebar").hide("slide", {direction: "left"})
  });


  /* Menu global */

  $(".panel-modulo").click(function(event) {
    
    // alert( $(this).data("modulo-id") )
    var moduloId = $(this).data("modulo-id");

    $(".row-submenu").hide();
    $(".row-submenu[data-modulo-id='" + moduloId + "']").show();

  });

})
