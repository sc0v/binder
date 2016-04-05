var Checkout = new function() {

	this.init = function() {
        // Prevent default submit action when you press enter 
		$('#user-card-number-input').bind("keydown", function() {
			if (window.event && window.event.keyCode == 13) {
				event.preventDefault();
				loadParticipant();
	     	}
	   	});

		// Bind event handler to org select to show or hide add membership option.
	    $("#org_name").bind('change', function(){
	      if($("#org_name").find('option:selected').attr('data-nonmember')){
	        $("#add_to_org_div").show();
	      }else{
	        $("#add_to_org").attr('checked', false);
	        $("#add_to_org_div").hide();
	      }
	   	});

		$('#user-card-number-input').focus(); 
	  	$('#user-card-number-input').bind("change", function() {
	    	loadParticipant();
	  	});
	};

	function loadParticipant(){
		$.ajax({
	        url: "/participants/lookup.json",
	        type: "POST",
	        data: {
	          card_number: $('#user-card-number-input').val()
	        }      
	    }).done( function(data) {
	    	var cko_participant = data;
		    $('#user-card-number-input').parent().children().first().val(data['id']);
		    $('#user-card-number-input').parent().children().last().html("</br><div class=\"panel panel-success\"><div class=\"panel-heading\">Participant Info</div><div class=\"panel-body\">" + data["name"] + "</div>");
	        if($('#charge_receiving_participant_id')) {
	        	$('#charge_receiving_participant_id').val(data['id']);
	        }
	        $("#org_name_div").fadeIn(500);
	        $("#checkout_submit_button").fadeIn(500);

	        // Reset the organization options
	        $("#org_name").empty();
	        $("#add_to_org").attr('checked', false);
	        $("#add_to_org_div").hide();

	        // Populate the organization select with options.
	        if(cko_participant['member_orgs'].length > 0){
	            $("#org_name").append('<optgroup label="Orgs ' + cko_participant['name'] +
	                              ' is in"></optgroup>');
	            cko_participant['member_orgs'].forEach(function(org){
	                $("#org_name").first().append('<option value="' + org['id'] + '">' + org['name'] + '</option>');
	            });
	            // Add blank line
	            $("#org_name").first().append('<option value="" disabled></option>');
	        }
	        $("#org_name").append('<optgroup label="All Organizations"></optgroup>');
	        cko_participant['non_member_orgs'].forEach(function(org){
	            $("#org_name").last().append('<option value="' + org['id'] + '" data-nonmember="true">' + org['name'] + '</option>');
	        });

	        if(cko_participant['member_orgs'].length == 0) $("#add_to_org_div").show();
	    }).error( function(data) {
	        $('#user-card-number-input').parent().children().first().val("");
		    $('#user-card-number-input').parent().children().last().html("</br><div class=\"panel panel-danger\"><div class=\"panel-heading\">Participant Not Found</div><div class=\"panel-body\">If this message persists please try entering their andrewid instead.</div>")
		});
	}
};
