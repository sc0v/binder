$(document).ready(function() {
  var card_number_input = $("#checkout_card_number");
  var tool_id_input = $("#checkout_tool_id");

  if(tool_id_input.val() == "") {
    tool_id_input.focus();
  } else {
    card_number_input.focus();
  }

  $("#new_checkout").submit(function(e) {
      if(card_number_input.val() == "") {
        card_number_input.focus();
        e.preventDefault();
        return false;
            
      } else if(tool_id_input.val() == "") {
        tool_id_input.focus();
        e.preventDefault();
        return false;
      }
  });
});