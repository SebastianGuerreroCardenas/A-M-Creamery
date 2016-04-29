// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require semantic_ui/semantic_ui
//= require_tree .

// adds the item class to all a tags, that have itemtags
$('div.itemtags a').addClass('item');


// javascripts calls that edit the paginate tags in order to add arrows for previous and next
$('.previous_page').addClass('icon');
$('.next_page').addClass('icon');
$('.previous_page').html('<i class="left chevron icon"></i>');
$('.next_page').html('<i class="right chevron icon"></i>');

// removes the previous_page and next_page from the a tags
$( "a" ).removeClass( "previous_page" );
$( "a" ).removeClass( "next_page" );

// adds a 'ui form' class to all the forms
$('form').addClass('ui form');

// for all selects tags adds a 'ui fluid search dropdown' class
$('select').addClass('ui fluid search dropdown');

// triggers dropdowns to work
$('select.dropdown')
  .dropdown()
;

// triggers the checkbox 
$('.ui.checkbox')
  .checkbox()
;

// when you click on the x of the flash messages it delets them with a fade
$('.message .close')
  .on('click', function() {
    $(this)
      .closest('.message')
      .transition('fade')
    ;
  })
;


//enables the side par for personal view
// $('.ui.labeled.icon.sidebar')
//   .sidebar('toggle')
// ;
