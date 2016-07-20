$(function(){
  var cache = {};
  
  // var availableTags = [
  //     "ActionScript",
  //     "AppleScript",
  //     "Asp",
  //     "BASIC",
  //     "C",
  //     "C++",
  //     "Clojure",
  //     "COBOL",
  //     "ColdFusion",
  //     "Erlang",
  //     "Fortran",
  //     "Groovy",
  //     "Haskell",
  //     "Java",
  //     "JavaScript",
  //     "Lisp",
  //     "Perl",
  //     "PHP",
  //     "Python",
  //     "Ruby",
  //     "Scala",
  //     "Scheme"
  //   ];
  //   $( "#localidade" ).autocomplete({
  //     source: availableTags
  //   });

  $( "#localidade" ).autocomplete({
      minLength: 2,
      source: function( request, response ) {
        var term = request.term;
        if ( term in cache ) {
          response( cache[ term ] );
          return;
        }

        $.getJSON( BASE_URL + "/localidades", request, function( data, status, xhr ) {
          var result = $.map(data.entidades, function (value, key) {
            return {
              id: value.loca_id,
              label: value.loca_nmlocalidade,
              value: value.loca_nmlocalidade
            };
          });

          cache[ term ] = result;
          response( result );
        });
      }
    });
  });