# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('table#tools').dataTable({
    "aoColumns": [
      { "bVisible": false },
      { "sType": "html", "bSearchable": false },
      null,
      { "sType": "html" },
      { "bSortable": false, "bSearchable": false},
      { "bSortable": false, "bSearchable": false}
    ]
  });
