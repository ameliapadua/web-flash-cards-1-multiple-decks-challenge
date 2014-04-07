$(document).ready(function () {
  $('#result-table').hide();
  $('#submit-deck-button').show();

  $("#target").submit(function(event){
    event.preventDefault();
    var str = $( '#target' ).serialize();
    var input = $("input:radio[name=option]:checked").val();
    var realAnswer = $( '#real-answer').val();
    var data = {"option": input, "real_answer": realAnswer};

    $.post('/deck/result', data, function(response) {
      $('#submit-deck-button').hide();

      if (response["result"] === "CORRECT") {
        var styledresult = "<p class='correct'>" + response["result"] + "</p>"
      }
      else {
        var styledresult = "<p class='incorrect'>" + response["result"] + "</p>"
      };

      $('#result').append(styledresult);
      $('#real_answer').append(response["real_answer"]);
      $('#user_guess').append(response["user_guess"]);
      $("input[type=radio]").attr("disabled", true);
      $('#result-table').show();
    });
  });
});
