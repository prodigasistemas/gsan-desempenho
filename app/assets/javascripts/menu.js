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

})
