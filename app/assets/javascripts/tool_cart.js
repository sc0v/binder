var ToolCart = new function(){
  // Panel selectors
  var $scan_tools_action,
      $checkout_action;

  // Scan tool action selectors
  var $scan_tool_input,
      $scan_tool_list,
      $scan_tool_list_table;

  // Checkout action selectors
  var $cko_tools_count,
      $cko_andrewid_input,
      $cko_loaded_participant_div,
      $cko_loaded_participant,
      $cko_loaded_participant_id,
      $cko_organization_select,
      $cko_add_membership_div,
      $cko_add_membership_ckb;

  this.initSidebarWidget = function(){
    // Panels
    $scan_tools_action = $('#tc_scan_tools_action');
    $checkout_action = $('#tc_checkout_action');

    // Scan tool action selectors
    $scan_tool_input = $('#tc_scan_tool');
    $scan_tool_list = $('#tc_tool_list');
    $scan_tool_list_table = $('#tc_tool_list_container');

    // Checkout action selectors
    $cko_tools_count = $('#tc_checkout_tools_count');
    $cko_andrewid_input = $('#tc_checkout_scan_andrewid');
    $cko_loaded_participant_div = $('#tc_checkout_loaded_participant_div');
    $cko_loaded_participant = $('#tc_checkout_loaded_participant');
    $cko_loaded_participant_id = $('#tc_checkout_loaded_participant_id');
    $cko_organization_select = $('#tc_checkout_select_organization');
    $cko_add_membership_div = $('#tc_checkout_add_membership_div');
    $cko_add_membership_ckb = $('#tc_checkout_add_membership');

    bindCheckoutEvents();
    bindScanEvents();

    $('[data-toggle="tooltip"]').tooltip();
    ToolCart.scanToolsAction();
  };

  // Scan tool Methods
  this.scanToolsAction = function(){
    $checkout_action.hide();
    $scan_tools_action.show();
    $scan_tool_input.focus();

    // Reset checkout action
    $cko_andrewid_input.val('');
    $cko_loaded_participant.html('');
    $cko_loaded_participant_id.val('');
    $cko_loaded_participant_div.hide();
    $cko_organization_select.empty();
    $cko_add_membership_ckb.attr('checked', false);
    $cko_add_membership_div.hide();
  };

  function bindScanEvents(){
    // Bind event handler for scanning tools
    $scan_tool_input.bind("keydown", function(event) {
      if (event && event.keyCode == 13) {
        event.preventDefault();
        $scan_tool_input.closest('form').trigger('submit');
      }
    });
  }

  // Checkout Methods
  this.checkoutAction = function(){
    var scannedToolsCount = $scan_tool_list.find('.cart-item').length,
        countSuffix = scannedToolsCount == 1 ? 'tool' : 'tools';

    if(scannedToolsCount < 1){
      ToolCart.showAlert('Scan some tools to checkout first.', false, 1500);
      $scan_tool_input.val('');
      $scan_tool_input.focus();
    }else{
      $scan_tools_action.hide();
      $cko_tools_count.html(scannedToolsCount + ' ' + countSuffix);
      $checkout_action.show();
      $cko_andrewid_input.focus();
    }
  };

  function bindCheckoutEvents(){
    // Bind event handler to org select to show or hide add membership option.
    $cko_organization_select.bind('change', function(){
      if($cko_organization_select.find('option:selected').attr('data-nonmember')){
        $cko_add_membership_div.show();
      }else{
        $cko_add_membership_ckb.attr('checked', false);
        $cko_add_membership_div.hide();
      }
    });

    // Bind checkout action events
    $cko_andrewid_input.bind("keydown", function(e){
      if(e.keyCode != 13) return;
      e.preventDefault();
      $.ajax({
        url: "/participants/lookup.json",
        type: "POST",
        data: {
          card_number: $cko_andrewid_input.val()
        }
      }).done( function(data) {
        var cko_participant = data;

        // Update the participant name.
        $cko_loaded_participant.html(cko_participant['name']);
        $cko_loaded_participant_id.val(cko_participant['id']);
        $cko_loaded_participant_div.fadeIn(500);

        // Reset the organization options
        $cko_organization_select.empty();
        $cko_add_membership_ckb.attr('checked', false);
        $cko_add_membership_div.hide();

        // Populate the organization select with options.
        if(cko_participant['member_orgs'].length > 0){
          $cko_organization_select.append('<optgroup label="Orgs ' + cko_participant['name'] +
                              ' is in" id="tc_checkout_select_member_orgs_group"></optgroup>');
          cko_participant['member_orgs'].forEach(function(org){
            $cko_organization_select.first().append('<option value="' + org['id'] + '">' + org['name'] + '</option>');
          });
          // Add blank line
          $cko_organization_select.first().append('<option value="" disabled></option>');
        }
        $cko_organization_select.append('<optgroup label="All Organizations"></optgroup>');
        cko_participant['non_member_orgs'].forEach(function(org){
          $cko_organization_select.last().append('<option value="' + org['id'] + '" data-nonmember="true">' + org['name'] + '</option>');
        });

        if(cko_participant['member_orgs'].length == 0) $cko_add_membership_div.show();
      }).error( function(data) {
        ToolCart.showAlert('Could not load person\'s information. Try manually entering their Andrew ID or ask for help.', false, 4500);
      });
    });
  }


  // Public Utility Methods
  var alertTimeout = null;
  this.showAlert = function(message, isSuccess, delay){
    var $alert = $('#tc_alert');

    if(isSuccess){
      $alert.removeClass('alert-danger').addClass('alert-success');
    }else{
      $alert.removeClass('alert-success').addClass('alert-danger');
    }

    if(alertTimeout) clearTimeout(alertTimeout);
    $('#tc_alert_message').html(message);
    $alert.stop();
    $alert.hide();
    $alert.fadeIn(250);
    alertTimeout = setTimeout(function(){
      $alert.fadeOut(500);
      alertTimeout = null;
    }, delay);
  };

  this.clearCartItems = function(){
    $('#tc_tool_list').empty();
    $('#tc_tool_list_container').hide();
  };




};