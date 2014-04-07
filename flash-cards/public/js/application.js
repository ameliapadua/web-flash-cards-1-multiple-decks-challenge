$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
  $('#new_card').submit(function(event){
    event.preventDefault();
    var term = $('#term').val();
    var definition = $('#definition').val();
    var data = {term: term, definition: definition}

    $.post("/cards/new", data, function(response){
      $('#term').val('').focus();
      $('#definition').val('');
    });
  });
});
