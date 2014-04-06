$(document).ready(function () {
  $('#result-table').hide();

  $("#target").submit(function(event){
    event.preventDefault();
    var str = $( '#target' ).serialize();
    var input = $("input:radio[name=option]:checked").val();
    var realAnswer = $( '#real-answer').val();
    var data = {"option": input, "real_answer": realAnswer};

    $.post('/deck/result', data, function(response) {
      console.log(response["user_guess"]);
      $('#result').append(response["result"]);
      $('#real_answer').append(response["real_answer"]);
      $('#user_guess').append(response["user_guess"]);
      $('#result-table').show();
    });
  });
});
