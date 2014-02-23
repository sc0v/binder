// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .


$(document).ready(function(){
	dynamicFaq();
    addFlashFadeOutListeners();
});

function addFlashFadeOutListeners() {
    $(function() {
       $('.alert-success').fadeIn('normal', function() {
          $(this).delay(2500).fadeOut();
       });
    });
    
    $(function() {
       $('.alert-error').fadeIn('normal', function() {
          $(this).delay(2500).fadeOut();
       });
    });
}

// This is buggy - it does not hide the correct elements
function dynamicFaq(){
	$('div.faq > dd').hide();
	$('div.faq > dt').bind('click', function(){
		$(this).toggleClass('open').next().slideToggle();;
	});
}

