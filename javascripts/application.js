$(document).ready(function(){
	$("#movies").dataTable({
    "bJQueryUI": true,
    "aaSorting": [[ 1, "desc" ]],
    "iDisplayLength": -1
  });

  $(".title").live('click', function() {
  	var synopsis = $(this).next(".synopsis");
  	if (synopsis.is(':visible')) {
  		synopsis.slideUp();
  	} else {
  		synopsis.slideDown();
  	}
  });
});